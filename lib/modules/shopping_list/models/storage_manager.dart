import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';

enum StorageKeys {
  shoppingList('shopping_lists');

  final String key;
  const StorageKeys(this.key);
}

class StorageManager {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string value
  static Future<bool> saveString(String key, String value) {
    return _prefs.setString(key, value);
  }

  // Get a string value
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save a list of strings
  static Future<bool> saveStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  // Get a list of strings
  static List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  // Remove a key
  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // Clear all storage
  static Future<bool> clear() {
    return _prefs.clear();
  }

  static Future<bool> saveShoppingList(ShoppingListModel list) {
    final lists = getShoppingLists();
    final existingIndex = lists.indexWhere((l) => l.id == list.id);

    if (existingIndex >= 0) {
      lists[existingIndex] = list;
    } else {
      lists.add(list);
    }

    final jsonList = lists.map((l) => l.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    return _prefs.setString(StorageKeys.shoppingList.key, jsonString);
  }

  static Future<bool> removeShoppingList(ShoppingListModel list) {
    final lists = getShoppingLists();
    lists.removeWhere((l) => l.id == list.id);
    final jsonList = lists.map((l) => l.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    return _prefs.setString(StorageKeys.shoppingList.key, jsonString);
  }

  static List<ShoppingListModel> getShoppingLists() {
    final jsonString = _prefs.getString(StorageKeys.shoppingList.key);
    if (jsonString == null) return [];
    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map(
            (item) => ShoppingListModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error decoding shopping list: $e');
      return [];
    }
  }
}

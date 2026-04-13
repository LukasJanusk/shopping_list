import 'package:shopping_list/modules/shopping_list/models/storage_manager.dart';
import 'shopping_list_model.dart';

class ShoppingListManager {
  List<ShoppingListModel> shoppingLists = [];

  ShoppingListManager() {
    loadShoppingLists();
  }
  Future<void> loadShoppingLists() async {
    shoppingLists = StorageManager.getShoppingLists();
  }

  void addShoppingList(ShoppingListModel shoppingList) {
    final existingIndex = shoppingLists.indexWhere(
      (list) => list.id == shoppingList.id,
    );

    if (existingIndex >= 0) {
      shoppingLists[existingIndex] = shoppingList;
    } else {
      shoppingLists.add(shoppingList);
    }

    StorageManager.saveShoppingList(shoppingList);
  }

  void removeShoppingLists(ShoppingListModel shoppingList) {
    shoppingLists.removeWhere((list) => list.id == shoppingList.id);
    StorageManager.removeShoppingList(shoppingList);
  }
}

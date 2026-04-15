import 'package:flutter/material.dart';
import 'shopping_list_item_model.dart';

class ShoppingListModel {
  String id = UniqueKey().toString();
  String name;
  List<ShoppingListItemModel> items;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  bool completed = false;

  ShoppingListModel({required this.name, List<ShoppingListItemModel>? items})
    : items = items ?? [];

  void addItem(ShoppingListItemModel item) {
    items.add(item);
    updatedAt = DateTime.now();
  }

  void removeItem(ShoppingListItemModel item) {
    items.remove(item);
    updatedAt = DateTime.now();
  }

  void updateName(String newName) {
    name = newName;
    updatedAt = DateTime.now();
  }

  void setCompleted(bool value) {
    completed = value;
    updatedAt = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'completed': completed,
    };
  }

  static ShoppingListModel fromJson(Map<String, dynamic> json) {
    return ShoppingListModel(
        name: json['name'],
        items: (json['items'] as List)
            .map(
              (item) =>
                  ShoppingListItemModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
      )
      ..id = json['id']
      ..createdAt = DateTime.parse(json['createdAt'])
      ..updatedAt = DateTime.parse(json['updatedAt'])
      ..completed = json['completed'] ?? false;
  }
}

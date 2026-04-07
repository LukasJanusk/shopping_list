import 'package:flutter/material.dart';

class ShoppingListItemModel {
  String id = UniqueKey().toString();
  String name;
  int quantity;
  bool isChecked;
  bool isFavorite;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  ShoppingListItemModel({
    required this.name,
    required this.quantity,
    this.isChecked = false,
    this.isFavorite = false,
  });

  void toggleChecked() {
    isChecked = !isChecked;
    updatedAt = DateTime.now();
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    updatedAt = DateTime.now();
  }

  void updateItem(String newName, int newQuantity) {
    name = newName;
    quantity = newQuantity;
    updatedAt = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'isChecked': isChecked,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static ShoppingListItemModel fromJson(Map<String, dynamic> json) {
    return ShoppingListItemModel(
        name: json['name'],
        quantity: json['quantity'],
        isChecked: json['isChecked'] ?? false,
        isFavorite: json['isFavorite'] ?? false,
      )
      ..id = json['id']
      ..createdAt = DateTime.parse(json['createdAt'])
      ..updatedAt = DateTime.parse(json['updatedAt']);
  }
}

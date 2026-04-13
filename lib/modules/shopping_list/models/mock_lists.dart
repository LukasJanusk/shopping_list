import 'shopping_list_model.dart';
import 'shopping_list_item_model.dart';

final List<ShoppingListModel> mockShoppingLists = [
  ShoppingListModel(
    name: 'Weekly Groceries',
    items: [
      ShoppingListItemModel(name: 'Milk', quantity: 2),
      ShoppingListItemModel(name: 'Bread', quantity: 1),
      ShoppingListItemModel(name: 'Eggs', quantity: 12),
      ShoppingListItemModel(name: 'Apples', quantity: 6),
      ShoppingListItemModel(name: 'Chicken', quantity: 1),
      ShoppingListItemModel(name: 'Rice', quantity: 1),
      ShoppingListItemModel(name: 'Tomatoes', quantity: 4),
    ],
  ),
  ShoppingListModel(
    name: 'Party Supplies',
    items: [
      ShoppingListItemModel(name: 'Chips', quantity: 3),
      ShoppingListItemModel(name: 'Soda', quantity: 12),
      ShoppingListItemModel(name: 'Cake', quantity: 1),
      ShoppingListItemModel(name: 'Napkins', quantity: 50),
      ShoppingListItemModel(name: 'Plates', quantity: 20),
    ],
  ),
  ShoppingListModel(
    name: 'Household Items',
    items: [
      ShoppingListItemModel(name: 'Toilet Paper', quantity: 2),
      ShoppingListItemModel(name: 'Laundry Detergent', quantity: 1),
      ShoppingListItemModel(name: 'Dish Soap', quantity: 1),
      ShoppingListItemModel(name: 'Light Bulbs', quantity: 4),
      ShoppingListItemModel(name: 'Batteries', quantity: 6),
    ],
  ),
  ShoppingListModel(
    name: 'Weekend Trip',
    items: [
      ShoppingListItemModel(name: 'Snacks', quantity: 5),
      ShoppingListItemModel(name: 'Water Bottles', quantity: 12),
      ShoppingListItemModel(name: 'Sunscreen', quantity: 1),
      ShoppingListItemModel(name: 'First Aid Kit', quantity: 1),
      ShoppingListItemModel(name: 'Blanket', quantity: 1),
    ],
  ),
];

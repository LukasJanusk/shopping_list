import 'package:flutter/material.dart';

class ShoppingListModal extends StatelessWidget {
  final Function(String name, int quantity) onAddItem;
  final Function(String itemId) onDeleteItem;
  final Function(String itemId) onToggleFavorite;
  final Function(String itemId) onToggleChecked;

  const ShoppingListModal({
    super.key,
    required this.onAddItem,
    required this.onDeleteItem,
    required this.onToggleFavorite,
    required this.onToggleChecked,
  });

  @override
  Widget build(BuildContext context) {
    String itemName = '';
    int quantity = 1;

    return AlertDialog(
      title: const Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => itemName = value,
            decoration: const InputDecoration(labelText: 'Item Name'),
          ),
          TextField(
            onChanged: (value) => quantity = int.tryParse(value) ?? 1,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (itemName.isNotEmpty) {
              onAddItem(itemName, quantity);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

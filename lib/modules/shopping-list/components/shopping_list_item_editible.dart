import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_item_model.dart';
import 'package:shopping_list/components/modals/bottomTitleEditModal.dart';

class ShoppingListItemEditible extends StatefulWidget {
  const ShoppingListItemEditible({
    super.key,
    required this.item,
    this.onDelete,
    this.increaseQuantity,
    this.decreaseQuantity,
    this.changeName,
  });

  final ShoppingListItemModel item;
  final VoidCallback? onDelete;
  final VoidCallback? increaseQuantity;
  final VoidCallback? decreaseQuantity;
  final VoidCallback? changeName;

  @override
  State<ShoppingListItemEditible> createState() =>
      _ShoppingListItemEditibleState();
}

class _ShoppingListItemEditibleState extends State<ShoppingListItemEditible> {
  void _openItemNameEditSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomTitleEditModal(
          title: widget.item.name,
          onTitleUpdate: (newName) {
            setState(() => widget.item.name = newName);
          },
          label: 'Item Name',
          hintText: 'Enter item name',
          modalTitle: 'Edit Item Name',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.indigo[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: _openItemNameEditSheet,
                child: Text(
                  widget.item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: widget.decreaseQuantity,
              icon: const Icon(Icons.remove),
              color: Colors.grey[600],
            ),
            SizedBox(
              width: 24,
              child: Text(
                '${widget.item.quantity}',
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              onPressed: widget.increaseQuantity,
              icon: const Icon(Icons.add),
              color: Colors.grey[600],
            ),
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete),
              color: Colors.red[700],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/components/shopping_list_item_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_item_model.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_model.dart';

class ShoppingNewListBottomSheet extends StatefulWidget {
  const ShoppingNewListBottomSheet({super.key, required this.onListCreated});

  final void Function(ShoppingListModel list) onListCreated;

  @override
  State<ShoppingNewListBottomSheet> createState() =>
      _ShoppingNewListBottomSheetState();
}

class _ShoppingNewListBottomSheetState
    extends State<ShoppingNewListBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final List<ShoppingListItemModel> _items = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addItemToList(Map<String, dynamic> itemData) {
    setState(() {
      _items.add(
        ShoppingListItemModel(
          name: itemData['name'],
          quantity: itemData['quantity'],
        ),
      );
    });
  }

  void _removeItem(ShoppingListItemModel item) {
    setState(() {
      _items.remove(item);
    });
  }

  void _showAddItemModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ShoppingListBottomSheet(onItemAdded: _addItemToList),
    );
  }

  void _createList() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final listName = _nameController.text.trim();
      final newList = ShoppingListModel(name: listName);

      // Add all items to the list
      for (final item in _items) {
        newList.addItem(item);
      }

      widget.onListCreated(newList);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context, newList);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () => Navigator.pop(context),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create New List',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'List Name',
                    border: OutlineInputBorder(),
                    hintText: 'Enter list name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a list name';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  autofocus: true,
                ),
                SizedBox(height: 16),
                if (_items.isNotEmpty) ...[
                  Text(
                    'Items (${_items.length})',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          dense: true,
                          title: Text(item.name),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: IconButton(
                            onPressed: () => _removeItem(item),
                            icon: const Icon(Icons.delete, size: 20),
                            color: Colors.red[400],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _showAddItemModal,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Item'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _createList,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text('Create List'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

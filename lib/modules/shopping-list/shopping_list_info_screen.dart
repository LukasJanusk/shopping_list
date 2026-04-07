import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/components/shopping_list_item_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_item_model.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_model.dart';
import 'package:shopping_list/modules/shopping-list/models/storage_manager.dart';

class ShoppingListInfoScreen extends StatefulWidget {
  const ShoppingListInfoScreen({super.key, this.list});

  final ShoppingListModel? list;

  @override
  State<ShoppingListInfoScreen> createState() => _ShoppingListInfoScreenState();
}

class _ShoppingListInfoScreenState extends State<ShoppingListInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ShoppingListModel? _list;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize list after context is available
    _list ??=
        widget.list ??
        (ModalRoute.of(context)?.settings.arguments as ShoppingListModel?) ??
        ShoppingListModel(name: 'New List');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleItemChecked(ShoppingListItemModel item) {
    setState(() {
      item.toggleChecked();
    });
  }

  void _deleteItem(ShoppingListItemModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _list?.removeItem(item));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _addItemToList(Map<String, dynamic> itemData) {
    setState(() {
      _list?.addItem(
        ShoppingListItemModel(
          name: itemData['name'],
          quantity: itemData['quantity'],
        ),
      );
    });
  }

  void showAddItemModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ShoppingListBottomSheet(onItemAdded: _addItemToList),
    );
  }

  void _onListSave() {
    if (!mounted || _list == null) return;
    StorageManager.saveShoppingList(_list!);
  }

  @override
  Widget build(BuildContext context) {
    // Ensure list is initialized
    final list = _list ?? ShoppingListModel(name: 'New List');

    return Scaffold(
      appBar: AppBar(title: Text(list.name)),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = list.items[index];
              return ListTile(
                title: Row(
                  children: [
                    TextButton(
                      onPressed: () => _toggleItemChecked(item),
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 20,
                          decoration: item.isChecked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text('Quantity: ${item.quantity}'),
                    IconButton(
                      onPressed: () => _deleteItem(item),
                      icon: const Icon(Icons.delete),
                      color: Colors.red[700],
                    ),
                  ],
                ),
              );
            }, childCount: list.items.length),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _onListSave,
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddItemModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

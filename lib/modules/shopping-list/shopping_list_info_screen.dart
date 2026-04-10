import 'package:flutter/material.dart';
import 'package:shopping_list/components/buttons/confirm_button.dart';
import 'package:shopping_list/modules/shopping-list/components/shopping_list_item_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping-list/components/shopping_list_item_editible.dart';
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

  void _increaseItemQuantity(ShoppingListItemModel item) {
    setState(() {
      if (item.quantity < 99) item.quantity++;
    });
  }

  void _decreaseItemQuantity(ShoppingListItemModel item) {
    if (item.quantity > 1) {
      setState(() {
        item.quantity--;
      });
    }
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
    Navigator.pop(context, true);
  }

  Future<void> _onListDelete() async {
    if (!mounted || _list == null) return;
    await StorageManager.removeShoppingList(_list!);

    if (!mounted) return;
    Navigator.pop(context, true);
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
              return ShoppingListItemEditible(
                item: item,
                onDelete: () => _deleteItem(item),
                increaseQuantity: () => _increaseItemQuantity(item),
                decreaseQuantity: () => _decreaseItemQuantity(item),
              );
            }, childCount: list.items.length),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConfirmButton(
                        onConfirmed: _onListDelete,
                        initialWidget: Text(
                          'Delete list',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red[700],
                          ),
                        ),
                        initialColor: Colors.red[100]!,
                        confirmColor: Colors.red[500]!,
                        confirmWidget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Confirm Delete',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onListSave,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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

import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/components/shopping_new_list_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_manager.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_model.dart';
import 'components/shopping_list_item.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const String _title = 'Shopping List';
  final ShoppingListManager shoppingListManager = ShoppingListManager();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shoppingListManager.loadShoppingLists();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onListCreated(ShoppingListModel list) {
    shoppingListManager.addShoppingList(list);
    setState(() {});
  }

  void showNewListBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ShoppingNewListBottomSheet(onListCreated: _onListCreated),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoppingLists = shoppingListManager.shoppingLists;
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: ListView.builder(
        itemCount: shoppingLists.length,
        itemBuilder: (context, index) {
          final list = shoppingLists[index];
          return ShoppingListItemWidget(list: list);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNewListBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

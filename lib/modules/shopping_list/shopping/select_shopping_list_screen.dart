import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_manager.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/modules/shopping_list/shopping/components/select_shopping_list_card.dart';

class SelectShoppingListScreen extends StatefulWidget {
  const SelectShoppingListScreen({super.key});

  @override
  State<SelectShoppingListScreen> createState() =>
      _SelectShoppingListScreenState();
}

class _SelectShoppingListScreenState extends State<SelectShoppingListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final String title = 'Select Shopping List';
  final ShoppingListManager shoppingListManager = ShoppingListManager();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shoppingListManager.loadShoppingLists();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onListCreated(ShoppingListModel list) {
    shoppingListManager.addShoppingList(list);
    setState(() {});
  }

  Future<void> reloadLists() async {
    await shoppingListManager.loadShoppingLists();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> openShoppingList(ShoppingListModel list) async {
    await Navigator.pushNamed(context, '/shopping', arguments: list);

    await reloadLists();
  }

  Future<void> navigateToCreateList() async {
    await Navigator.pushNamed(context, '/create-list');
  }

  @override
  Widget build(BuildContext context) {
    final shoppingLists = shoppingListManager.shoppingLists;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Builder(
        builder: (context) {
          if (shoppingLists.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('No shopping lists available.'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: navigateToCreateList,
                    child: Text('Create Your First List'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: shoppingLists.length,
              itemBuilder: (context, index) {
                final list = shoppingLists[index];
                return SelectShoppingListCard(
                  list: list,
                  onTap: () => openShoppingList(list),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

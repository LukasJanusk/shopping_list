import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/modules/shopping_list/components/shopping_list_card.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_manager.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/app_assets.dart';
import 'package:shopping_list/theme/color_theme.dart';

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
    await Navigator.pushNamed(
      context,
      '/create-list',
      arguments: {'showCreateListBottomSheet': true},
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoppingLists = shoppingListManager.shoppingLists
        .where((list) => !list.completed)
        .toList();
    return AppScaffold(
      appBar: AppTopBar(title: Text(title)),
      body: Builder(
        builder: (context) {
          if (shoppingLists.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.emptyLists, height: 200),
                    const SizedBox(height: 24),
                    Text(
                      'No shopping lists yet',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Start with a fresh list and keep everything you need in one place.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.inkSoft,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: navigateToCreateList,
                      icon: const Icon(Icons.playlist_add_rounded),
                      label: const Text('Create Your First List'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: shoppingLists.length,
            itemBuilder: (context, index) {
              final list = shoppingLists[index];
              return ShoppingListCard(
                list: list,
                variant: list.completed
                    ? ShoppingListCardVariant.primary
                    : ShoppingListCardVariant.secondary,
                onTap: () => openShoppingList(list),
              );
            },
          );
        },
      ),
      floatingActionButton: shoppingLists.isNotEmpty
          ? FloatingActionButton(
              onPressed: navigateToCreateList,
              backgroundColor: AppColors.coral,
              child: const Icon(Icons.add_rounded, color: Colors.white),
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/components/ui/empty_state.dart';
import 'package:shopping_list/l10n/l10n.dart';
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
  final ShoppingListManager shoppingListManager = ShoppingListManager();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reloadLists();
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

    await reloadLists();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final shoppingLists = shoppingListManager.shoppingLists
        .where((list) => !list.completed)
        .toList();
    return AppScaffold(
      appBar: AppTopBar(title: Text(l10n.selectShoppingList)),
      body: Builder(
        builder: (context) {
          if (shoppingLists.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  MediaQuery.of(context).padding.bottom + 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    EmptyState(
                      asset: AppAssets.emptyLists,
                      title: l10n.noShoppingLists,
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: navigateToCreateList,
                      icon: const Icon(Icons.playlist_add_rounded),
                      label: Text(l10n.createList),
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

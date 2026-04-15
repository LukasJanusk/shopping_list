import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/components/ui/floating_pointer_with_text.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/modules/shopping_list/create_list/components/shopping_new_list_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping_list/components/shopping_list_card.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_manager.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/app_assets.dart';
import 'package:shopping_list/theme/color_theme.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key, this.showCreateListBottomSheet = false});

  final bool showCreateListBottomSheet;

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final ShoppingListManager shoppingListManager = ShoppingListManager();
  bool _didScheduleCreateListBottomSheet = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shoppingListManager.loadShoppingLists();

    if (_didScheduleCreateListBottomSheet ||
        !_shouldShowCreateListBottomSheet(context)) {
      return;
    }

    _didScheduleCreateListBottomSheet = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showNewListBottomSheet();
    });
  }

  bool _shouldShowCreateListBottomSheet(BuildContext context) {
    if (widget.showCreateListBottomSheet) {
      return true;
    }

    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, dynamic>) {
      return arguments['showCreateListBottomSheet'] == true;
    }

    return false;
  }

  void _onListCreated(ShoppingListModel list) {
    shoppingListManager.addShoppingList(list);
    setState(() {});
  }

  Future<void> _reloadLists() async {
    await shoppingListManager.loadShoppingLists();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _openShoppingList(ShoppingListModel list) async {
    await Navigator.pushNamed(context, '/shopping-list-info', arguments: list);

    await _reloadLists();
  }

  Future<void> showNewListBottomSheet() async {
    final newList = await showAppBottomSheet<ShoppingListModel>(
      context: context,
      builder: (context) => const ShoppingNewListBottomSheet(),
    );

    if (!mounted || newList == null) return;

    _onListCreated(newList);
    await Navigator.pushNamed(
      context,
      '/shopping-list-info',
      arguments: newList,
    );
    await _reloadLists();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final shoppingLists = shoppingListManager.shoppingLists;
    return AppScaffold(
      appBar: AppTopBar(title: Text(l10n.shoppingLists)),
      body: Builder(
        builder: (context) {
          if (shoppingLists.isEmpty) {
            return Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.emptyLists, height: 200),
                        const SizedBox(height: 24),
                        Text(
                          l10n.noShoppingListsYet,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                              ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          l10n.emptyListsDescription,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.inkSoft, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                FloatingTextWithPointer(text: l10n.tapCreateFirstList),
              ],
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
                onTap: () => _openShoppingList(list),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNewListBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list/components/buttons/confirm_button.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/components/modals/app_popup_dialog.dart';
import 'package:shopping_list/components/modals/bottom_title_edit_modal.dart';
import 'package:shopping_list/components/ui/empty_state.dart';
import 'package:shopping_list/components/ui/floating_pointer_with_text.dart';
import 'package:shopping_list/modules/shopping_list/create_list/components/shopping_list_item_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping_list/create_list/components/shopping_list_item_editible.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_item_model.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/modules/shopping_list/models/storage_manager.dart';
import 'package:shopping_list/theme/app_assets.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

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
    showAppPopupDialog<void>(
      context: context,
      title: 'Delete item?',
      message:
          'Remove "${item.name}" from this shopping list? This action cannot be undone.',
      confirmLabel: 'Delete',
      variant: AppPopupDialogVariant.danger,
      icon: Icons.delete_outline_rounded,
      onConfirm: () {
        setState(() => _list?.removeItem(item));
      },
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
    showAppBottomSheet(
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

  void _updateListTitle(String newTitle) {
    setState(() {
      if (_list != null) _list!.name = newTitle;
    });
  }

  void _onListTitleTap() {
    showAppBottomSheet(
      context: context,
      builder: (context) {
        return BottomTitleEditModal(
          title: 'Edit List Title',
          onTitleUpdate: _updateListTitle,
          label: 'List Title',
          hintText: 'Enter list title',
          modalTitle: 'Edit List Title',
        );
      },
    );
  }

  Widget _buildDeleteButton() {
    return ConfirmButton(
      onConfirmed: _onListDelete,
      initialWidget: Text(
        'Delete list',
        style: TextStyle(fontSize: 18, color: Colors.red[700]),
      ),
      confirmWidget: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Delete',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _onListSave,
      style: AppDecorations.actionButtonStyle(
        backgroundColor: AppColors.ink.withAlpha(18),
        foregroundColor: AppColors.ink,
        borderColor: AppColors.ink.withAlpha(48),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      child: const Text(
        'Save',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildBottomActions({required bool showSave}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_buildDeleteButton(), if (showSave) _buildSaveButton()],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure list is initialized
    final list = _list ?? ShoppingListModel(name: 'New List');

    return AppScaffold(
      appBar: AppTopBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(list.name),
            SizedBox(width: 8),
            IconButton(icon: Icon(Icons.edit), onPressed: _onListTitleTap),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          if (list.items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                EmptyState(
                  asset: AppAssets.emptyLists,
                  title: 'Your list is empty',
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 56.0),
                  child: FloatingTextWithPointer(
                    text: 'Tap + to add items to your list!',
                  ),
                ),
                _buildBottomActions(showSave: false),
              ],
            );
          }
          return CustomScrollView(
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
                child: _buildBottomActions(showSave: true),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddItemModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

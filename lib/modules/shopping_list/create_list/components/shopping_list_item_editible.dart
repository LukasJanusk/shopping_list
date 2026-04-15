import 'package:flutter/material.dart';
import 'package:shopping_list/components/modals/app_bottom_sheet.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_item_model.dart';
import 'package:shopping_list/components/modals/bottom_title_edit_modal.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

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
    showAppBottomSheet(
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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: AppDecorations.elevatedCard(color: AppColors.surface),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _openItemNameEditSheet,
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    foregroundColor: AppColors.ink,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDecorations.cardRadius,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit_note_rounded,
                        size: 20,
                        color: AppColors.coral,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.ink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.canvas,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.inkSoft.withAlpha(28)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: widget.decreaseQuantity,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.remove_rounded),
                      color: AppColors.teal,
                    ),
                    SizedBox(
                      width: 28,
                      child: Text(
                        '${widget.item.quantity}',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: widget.increaseQuantity,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.add_rounded),
                      color: AppColors.teal,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 60,
                child: Material(
                  color: AppColors.error.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: widget.onDelete,
                    customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    splashColor: AppColors.error.withAlpha(70),
                    highlightColor: AppColors.error.withAlpha(36),
                    child: const Center(
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_item_model.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

class HistoryListItemCard extends StatelessWidget {
  const HistoryListItemCard({super.key, required this.item});

  final ShoppingListItemModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPurchased = item.isChecked;
    final accentColor = isPurchased ? AppColors.teal : AppColors.inkSoft;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: AppDecorations.elevatedCard(
          color: AppColors.surface,
          borderColor: accentColor.withAlpha(isPurchased ? 40 : 24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(isPurchased ? 16 : 10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  isPurchased
                      ? Icons.check_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 20,
                  color: accentColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isPurchased ? AppColors.ink : AppColors.inkSoft,
                    fontWeight: FontWeight.w700,
                    decoration: isPurchased
                        ? TextDecoration.none
                        : TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(isPurchased ? 12 : 8),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: accentColor.withAlpha(24)),
                ),
                child: Text(
                  'x${item.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isPurchased ? AppColors.teal : AppColors.ink,
                    fontWeight: FontWeight.w800,
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

enum ShoppingListCardVariant { surface, primary, secondary }

class ShoppingListCard extends StatelessWidget {
  const ShoppingListCard({
    super.key,
    required this.list,
    required this.onTap,
    this.variant = ShoppingListCardVariant.surface,
    this.editable = false,
  });

  final ShoppingListModel list;
  final FutureOr<void> Function() onTap;
  final ShoppingListCardVariant variant;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final accentColor = switch (variant) {
      ShoppingListCardVariant.primary => AppColors.coral,
      ShoppingListCardVariant.secondary => AppColors.teal,
      ShoppingListCardVariant.surface => AppColors.inkSoft,
    };
    final cardColor = Colors.white.withAlpha(235);
    final borderColor = switch (variant) {
      ShoppingListCardVariant.primary => AppColors.coral.withAlpha(40),
      ShoppingListCardVariant.secondary => AppColors.teal.withAlpha(40),
      ShoppingListCardVariant.surface => AppColors.inkSoft.withAlpha(18),
    };
    final splashColor = switch (variant) {
      ShoppingListCardVariant.primary => AppColors.coralPressed,
      ShoppingListCardVariant.secondary => AppColors.tealPressed,
      ShoppingListCardVariant.surface => AppColors.tealPressed,
    };
    final highlightColor = switch (variant) {
      ShoppingListCardVariant.primary => AppColors.coral.withAlpha(18),
      ShoppingListCardVariant.secondary => AppColors.teal.withAlpha(18),
      ShoppingListCardVariant.surface => AppColors.teal.withAlpha(14),
    };
    final titleColor = AppColors.ink;
    final subtitleColor = AppColors.inkSoft;
    final arrowBadgeColor = accentColor.withAlpha(18);
    final arrowColor = accentColor;
    final countBadgeColor = accentColor.withAlpha(10);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: AppDecorations.elevatedCard(
          color: cardColor,
          borderColor: borderColor,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: AppDecorations.cardRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () async {
              await onTap();
            },
            splashColor: splashColor,
            highlightColor: highlightColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            list.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: titleColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: countBadgeColor,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              l10n.itemCount(list.items.length),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: subtitleColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: arrowBadgeColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        editable
                            ? Icons.edit_rounded
                            : Icons.arrow_forward_rounded,
                        size: 20,
                        color: arrowColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

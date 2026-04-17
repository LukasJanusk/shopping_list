import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/components/ui/app_info_chip.dart';
import 'package:shopping_list/components/ui/divider_with_title.dart';
import 'package:shopping_list/components/ui/empty_state.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/modules/history/components/history_list_item_card.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/app_assets.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

class HistoryInfoScreen extends StatefulWidget {
  const HistoryInfoScreen({super.key, this.list});

  final ShoppingListModel? list;

  @override
  State<HistoryInfoScreen> createState() => _HistoryInfoScreenState();
}

class _HistoryInfoScreenState extends State<HistoryInfoScreen> {
  ShoppingListModel? _list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _list ??=
        widget.list ??
        (ModalRoute.of(context)?.settings.arguments as ShoppingListModel?);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final list = _list;

    if (list == null) {
      return AppScaffold(
        showShapes: false,
        appBar: AppTopBar(title: Text(l10n.shoppingHistory)),
        body: Center(child: Text(l10n.noShoppingListSelected)),
      );
    }

    final locale = Localizations.localeOf(context).toString();
    final completedOn = DateFormat.yMMMMd(locale).format(list.updatedAt);
    final bottomSafePadding = MediaQuery.of(context).padding.bottom;

    return AppScaffold(
      appBar: AppTopBar(title: Text(list.name)),
      showShapes: false,
      body: Builder(
        builder: (context) {
          if (list.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: EmptyState(
                  asset: AppAssets.emptyLists,
                  title: l10n.noPurchasedItems,
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: DecoratedBox(
                  decoration: AppDecorations.elevatedCard(
                    color: AppColors.surface,
                    borderColor: AppColors.teal.withAlpha(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.purchasedItems,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            AppInfoChip(
                              icon: Icons.event_rounded,
                              label: l10n.completedOn(completedOn),
                            ),
                            AppInfoChip(
                              icon: Icons.shopping_bag_rounded,
                              label: l10n.itemCount(list.items.length),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DividerWithTitle(title: l10n.purchasedItems),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Stack(
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.only(
                              top: 12,
                              bottom: bottomSafePadding + 16,
                            ),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: list.items.length,
                            itemBuilder: (context, index) {
                              final item = list.items[index];
                              return HistoryListItemCard(item: item);
                            },
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: IgnorePointer(
                              child: Container(
                                height: 16,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.canvas,
                                      AppColors.canvas.withAlpha(220),
                                      AppColors.canvas.withAlpha(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

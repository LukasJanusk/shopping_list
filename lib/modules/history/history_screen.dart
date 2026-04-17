import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/components/ui/divider_with_title.dart';
import 'package:shopping_list/components/ui/empty_state.dart';
import 'package:shopping_list/core/storage_manager.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/modules/history/models/history_day_section.dart';
import 'package:shopping_list/modules/shopping_list/components/shopping_list_card.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/theme/app_assets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ShoppingListModel> _completedLists = const [];

  @override
  void initState() {
    super.initState();
    _loadCompletedLists();
  }

  Future<void> _loadCompletedLists() async {
    final completedLists =
        StorageManager.getShoppingLists()
            .where((list) => list.completed)
            .toList()
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    if (!mounted) return;
    setState(() {
      _completedLists = completedLists;
    });
  }

  Future<void> _openHistoryInfo(ShoppingListModel list) async {
    await Navigator.pushNamed(context, '/history-info', arguments: list);

    await _loadCompletedLists();
  }

  List<HistoryDaySection> _buildDaySections(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formatter = DateFormat.yMMMMd(locale);
    final sections = <HistoryDaySection>[];

    for (final list in _completedLists) {
      final updatedDate = DateTime(
        list.updatedAt.year,
        list.updatedAt.month,
        list.updatedAt.day,
      );

      if (sections.isNotEmpty && sections.last.date == updatedDate) {
        sections.last.lists.add(list);
        continue;
      }

      sections.add(
        HistoryDaySection(
          date: updatedDate,
          title: formatter.format(updatedDate),
          lists: [list],
        ),
      );
    }

    return sections;
  }

  Widget _buildHistoryList(BuildContext context) {
    final daySections = _buildDaySections(context);

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: daySections.length,
      itemBuilder: (context, index) {
        final section = daySections[index];

        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DividerWithTitle(title: section.title),
              ),
              const SizedBox(height: 8),
              ...section.lists.map(
                (list) => ShoppingListCard(
                  list: list,
                  onTap: () => _openHistoryInfo(list),
                  variant: ShoppingListCardVariant.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      appBar: AppTopBar(title: Text(l10n.shoppingHistory)),
      body: Builder(
        builder: (context) {
          if (_completedLists.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: EmptyState(
                  asset: AppAssets.emptyLists,
                  title: l10n.shoppingHistoryPlaceholder,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadCompletedLists,
            child: _buildHistoryList(context),
          );
        },
      ),
    );
  }
}

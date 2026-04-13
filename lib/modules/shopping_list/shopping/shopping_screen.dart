import 'package:flutter/material.dart';
import 'package:shopping_list/components/ui/divider_with_title.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_item_model.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/modules/shopping_list/models/storage_manager.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  static const _itemAnimationDuration = Duration(milliseconds: 280);
  static const _sectionResizeDuration = Duration(milliseconds: 220);
  static const _estimatedItemExtent = 72.0;
  static const _sectionChromeExtent = 76.0;
  static const _minimumVisibleSectionHeight = _sectionChromeExtent;
  static const _minimumSingleItemSectionHeight = 168.0;
  static const _minimumCheckedSectionHeight =
      _sectionChromeExtent + (_estimatedItemExtent * 2);

  ShoppingListModel? _list;
  final _checkedListKey = GlobalKey<AnimatedListState>();
  final _uncheckedListKey = GlobalKey<AnimatedListState>();
  final List<ShoppingListItemModel> _checkedItems = [];
  final List<ShoppingListItemModel> _uncheckedItems = [];
  bool _didInitializeSections = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _list ??= ModalRoute.of(context)?.settings.arguments as ShoppingListModel?;

    if (!_didInitializeSections && _list != null) {
      _checkedItems
        ..clear()
        ..addAll(_list!.items.where((item) => item.isChecked));
      _uncheckedItems
        ..clear()
        ..addAll(_list!.items.where((item) => !item.isChecked));
      _didInitializeSections = true;
    }
  }

  Future<void> _toggleItemChecked(ShoppingListItemModel item) async {
    final movesToChecked = !item.isChecked;
    final sourceItems = movesToChecked ? _uncheckedItems : _checkedItems;
    final targetItems = movesToChecked ? _checkedItems : _uncheckedItems;
    final sourceListKey = movesToChecked ? _uncheckedListKey : _checkedListKey;
    final targetListKey = movesToChecked ? _checkedListKey : _uncheckedListKey;
    final sourceIndex = sourceItems.indexWhere((entry) => entry.id == item.id);

    if (sourceIndex == -1) return;

    final sourceAnimatedIndex = _animatedIndexForLogicalIndex(
      sourceIndex,
      sourceItems.length,
    );

    final removedItem = sourceItems.removeAt(sourceIndex);
    sourceListKey.currentState?.removeItem(
      sourceAnimatedIndex,
      (context, animation) => _buildAnimatedItem(
        item: removedItem,
        animation: animation,
        slideFromTop: movesToChecked,
      ),
      duration: _itemAnimationDuration,
    );

    removedItem.toggleChecked();

    final targetIndex = movesToChecked ? targetItems.length : 0;
    targetItems.insert(targetIndex, removedItem);
    final targetAnimatedIndex = _animatedIndexForLogicalIndex(
      targetIndex,
      targetItems.length,
    );
    targetListKey.currentState?.insertItem(
      targetAnimatedIndex,
      duration: _itemAnimationDuration,
    );

    final list = _list;
    if (list != null) {
      list.items
        ..clear()
        ..addAll(_checkedItems)
        ..addAll(_uncheckedItems);
    }

    setState(() {});

    if (list == null) return;

    await StorageManager.saveShoppingList(list);
  }

  int _animatedIndexForLogicalIndex(int logicalIndex, int itemCount) {
    return itemCount - 1 - logicalIndex;
  }

  Widget _buildItemTile(ShoppingListItemModel item) {
    return Card(
      child: CheckboxListTile(
        value: item.isChecked,
        onChanged: (_) => _toggleItemChecked(item),
        title: Text(item.name),
        subtitle: Text('Quantity: ${item.quantity}'),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildAnimatedItem({
    required ShoppingListItemModel item,
    required Animation<double> animation,
    required bool slideFromTop,
  }) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return FadeTransition(
      opacity: curvedAnimation,
      child: SizeTransition(
        sizeFactor: curvedAnimation,
        axisAlignment: slideFromTop ? -1 : 1,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, slideFromTop ? -0.12 : 0.12),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Padding(
            padding: EdgeInsets.only(bottom: slideFromTop ? 4 : 8),
            child: _buildItemTile(item),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<ShoppingListItemModel> items,
    required bool checked,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...[DividerWithTitle(title: title), const SizedBox(height: 12)],
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: items.isEmpty
                  ? ListView(
                      key: ValueKey('empty-$checked'),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: Text(
                            checked
                                ? 'No checked items yet.'
                                : 'No unchecked items.',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    )
                  : AnimatedList(
                      key: checked ? _checkedListKey : _uncheckedListKey,
                      initialItemCount: items.length,
                      reverse: true,
                      itemBuilder: (context, index, animation) {
                        final logicalIndex = _animatedIndexForLogicalIndex(
                          index,
                          items.length,
                        );
                        final item = items[logicalIndex];
                        return _buildAnimatedItem(
                          item: item,
                          animation: animation,
                          slideFromTop: checked,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  double _estimatedSectionHeight(int itemCount, {required bool checked}) {
    var estimatedHeight =
        _sectionChromeExtent + (itemCount * _estimatedItemExtent);

    if (itemCount == 1 && estimatedHeight < _minimumSingleItemSectionHeight) {
      estimatedHeight = _minimumSingleItemSectionHeight;
    }

    if (checked && estimatedHeight < _minimumCheckedSectionHeight) {
      estimatedHeight = _minimumCheckedSectionHeight;
    }

    return estimatedHeight;
  }

  @override
  Widget build(BuildContext context) {
    final list = _list;

    if (list == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Shopping')),
        body: const Center(child: Text('No shopping list selected.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(list.name)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final availableHeight = maxHeight;

          late double checkedSectionHeight;
          late double uncheckedSectionHeight;

          if (_checkedItems.isEmpty) {
            checkedSectionHeight = 0;
            uncheckedSectionHeight = maxHeight;
          } else if (_uncheckedItems.isEmpty) {
            checkedSectionHeight = maxHeight;
            uncheckedSectionHeight = 0;
          } else {
            final checkedDesiredHeight = _estimatedSectionHeight(
              _checkedItems.length,
              checked: true,
            );
            final uncheckedDesiredHeight = _estimatedSectionHeight(
              _uncheckedItems.length,
              checked: false,
            );
            final maxUncheckedHeight =
                (availableHeight - _minimumCheckedSectionHeight).clamp(
                  _sectionChromeExtent,
                  availableHeight,
                );

            uncheckedSectionHeight = uncheckedDesiredHeight.clamp(
              _sectionChromeExtent,
              maxUncheckedHeight,
            );
            checkedSectionHeight = (availableHeight - uncheckedSectionHeight)
                .clamp(_minimumCheckedSectionHeight, maxHeight);

            if (checkedSectionHeight > checkedDesiredHeight &&
                uncheckedDesiredHeight < uncheckedSectionHeight) {
              uncheckedSectionHeight = uncheckedDesiredHeight;
              checkedSectionHeight = availableHeight - uncheckedSectionHeight;
            }
          }

          final showCheckedSection =
              checkedSectionHeight >= _minimumVisibleSectionHeight;
          final showUncheckedSection =
              uncheckedSectionHeight >= _minimumVisibleSectionHeight;

          return Column(
            children: [
              ClipRect(
                child: AnimatedContainer(
                  duration: _sectionResizeDuration,
                  curve: Curves.easeInOut,
                  height: checkedSectionHeight,
                  child: showCheckedSection
                      ? _buildSection(
                          title: 'Checked',
                          items: _checkedItems,
                          checked: true,
                        )
                      : null,
                ),
              ),
              ClipRect(
                child: AnimatedContainer(
                  duration: _sectionResizeDuration,
                  curve: Curves.easeInOut,
                  height: uncheckedSectionHeight,
                  child: showUncheckedSection
                      ? _buildSection(
                          title: 'Unchecked',
                          items: _uncheckedItems,
                          checked: false,
                        )
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

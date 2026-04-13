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
  static const _rowAnimationDuration = Duration(milliseconds: 240);
  static const _sectionResizeDuration = Duration(milliseconds: 220);
  static const _estimatedItemExtent = 72.0;
  static const _sectionChromeExtent = 76.0;
  static const _minimumVisibleSectionHeight = _sectionChromeExtent;
  static const _minimumSectionHeight =
      _sectionChromeExtent + (_estimatedItemExtent * 2);

  ShoppingListModel? _list;
  final _checkedListKey = GlobalKey<AnimatedListState>();
  final _uncheckedListKey = GlobalKey<AnimatedListState>();
  final List<ShoppingListItemModel> _checkedItems = [];
  final List<ShoppingListItemModel> _uncheckedItems = [];
  bool _didInitializePresentationLists = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _list ??= ModalRoute.of(context)?.settings.arguments as ShoppingListModel?;

    if (!_didInitializePresentationLists && _list != null) {
      _initializePresentationLists(_list!);
      _didInitializePresentationLists = true;
    }
  }

  void _initializePresentationLists(ShoppingListModel list) {
    _checkedItems
      ..clear()
      ..addAll(list.items.where((item) => item.isChecked));
    _uncheckedItems
      ..clear()
      ..addAll(list.items.where((item) => !item.isChecked));
  }

  Future<void> _toggleItemChecked(ShoppingListItemModel item) async {
    final list = _list;
    if (list == null) return;

    final sourceChecked = item.isChecked;
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
    final movedItem = sourceItems.removeAt(sourceIndex);

    sourceListKey.currentState?.removeItem(
      sourceAnimatedIndex,
      (context, animation) => _buildAnimatedItem(
        item: movedItem,
        animation: animation,
        checked: sourceChecked,
      ),
      duration: _rowAnimationDuration,
    );

    movedItem.toggleChecked();

    final targetIndex = movesToChecked ? targetItems.length : 0;
    targetItems.insert(targetIndex, movedItem);
    final targetAnimatedIndex = _animatedIndexForLogicalIndex(
      targetIndex,
      targetItems.length,
    );

    targetListKey.currentState?.insertItem(
      targetAnimatedIndex,
      duration: _rowAnimationDuration,
    );

    list.items
      ..clear()
      ..addAll(_checkedItems)
      ..addAll(_uncheckedItems);

    setState(() {});

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
    required bool checked,
  }) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return FadeTransition(
      opacity: curvedAnimation,
      child: SizeTransition(
        sizeFactor: curvedAnimation,
        axisAlignment: checked ? -1 : 1,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, checked ? -0.08 : 0.08),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Padding(
            padding: EdgeInsets.only(bottom: checked ? 4 : 8),
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
                          checked: checked,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  double _estimatedSectionHeight(int itemCount) {
    var estimatedHeight =
        _sectionChromeExtent + (itemCount * _estimatedItemExtent);

    if (estimatedHeight < _minimumSectionHeight) {
      estimatedHeight = _minimumSectionHeight;
    }

    return estimatedHeight;
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Shopping')),
        body: const Center(child: Text('No shopping list selected.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_list!.name)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final availableHeight = maxHeight;
          final checkedItems = _checkedItems;
          final uncheckedItems = _uncheckedItems;

          late double checkedSectionHeight;
          late double uncheckedSectionHeight;

          if (checkedItems.isEmpty) {
            checkedSectionHeight = 0;
            uncheckedSectionHeight = maxHeight;
          } else if (uncheckedItems.isEmpty) {
            checkedSectionHeight = maxHeight;
            uncheckedSectionHeight = 0;
          } else {
            final checkedDesiredHeight = _estimatedSectionHeight(
              checkedItems.length,
            );
            final uncheckedDesiredHeight = _estimatedSectionHeight(
              uncheckedItems.length,
            );
            final maxUncheckedHeight = (availableHeight - _minimumSectionHeight)
                .clamp(_sectionChromeExtent, availableHeight);

            uncheckedSectionHeight = uncheckedDesiredHeight.clamp(
              _sectionChromeExtent,
              maxUncheckedHeight,
            );
            checkedSectionHeight = (availableHeight - uncheckedSectionHeight)
                .clamp(_minimumSectionHeight, maxHeight);

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
                          items: checkedItems,
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
                          items: uncheckedItems,
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

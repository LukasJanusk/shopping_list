import 'package:flutter/material.dart';
import 'package:shopping_list/theme/color_theme.dart';

class AppDropdownSettingSelect<T> extends StatefulWidget {
  const AppDropdownSettingSelect({
    super.key,
    this.value,
    this.onChanged,
    required this.items,
    this.popupMenuPosition = PopupMenuPosition.under,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>> items;
  final PopupMenuPosition popupMenuPosition;

  @override
  State<AppDropdownSettingSelect<T>> createState() =>
      _AppDropdownSettingSelectState<T>();
}

class _AppDropdownSettingSelectState<T>
    extends State<AppDropdownSettingSelect<T>> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final popupTheme = theme.copyWith(
      splashColor: AppColors.tealPressed,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
    final selectedItem = widget.items.cast<DropdownMenuItem<T>?>().firstWhere(
      (item) => item?.value == widget.value,
      orElse: () => null,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 156),

      child: Theme(
        data: popupTheme,

        child: PopupMenuButton<T>(
          tooltip: '',
          enabled: widget.onChanged != null,
          color: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 8,
          position: widget.popupMenuPosition,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          borderRadius: BorderRadius.circular(18),
          padding: EdgeInsets.zero,
          onOpened: () {
            setState(() {
              _isMenuOpen = true;
            });
          },
          onCanceled: () {
            setState(() {
              _isMenuOpen = false;
            });
          },
          onSelected: (selectedValue) {
            setState(() {
              _isMenuOpen = false;
            });
            widget.onChanged?.call(selectedValue);
          },
          itemBuilder: (context) {
            return widget.items.map((item) {
              final isSelected = item.value == widget.value;

              return PopupMenuItem<T>(
                value: item.value,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.tealPressed.withValues(alpha: 0.42)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: DefaultTextStyle(
                    style:
                        theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.ink,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ) ??
                        const TextStyle(),
                    child: item.child,
                  ),
                ),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.inkSoft.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: DefaultTextStyle(
                    style:
                        theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w600,
                        ) ??
                        const TextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    child: selectedItem?.child ?? const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 6),
                AnimatedRotation(
                  turns: _isMenuOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.inkSoft,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

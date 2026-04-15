import 'package:flutter/material.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

enum ConfirmButtonVariant { success, error, alert }

class ConfirmButton extends StatefulWidget {
  final VoidCallback onConfirmed;
  final Widget? initialWidget;
  final Widget? confirmWidget;
  final ConfirmButtonVariant variant;

  const ConfirmButton({
    super.key,
    required this.onConfirmed,
    this.initialWidget,
    this.confirmWidget,
    this.variant = ConfirmButtonVariant.error,
  });

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  bool _confirming = false;

  Color _variantColor(ConfirmButtonVariant variant) {
    switch (variant) {
      case ConfirmButtonVariant.success:
        return AppColors.teal;
      case ConfirmButtonVariant.error:
        return AppColors.error;
      case ConfirmButtonVariant.alert:
        return AppColors.warning;
    }
  }

  Color _variantAccent(ConfirmButtonVariant variant) {
    switch (variant) {
      case ConfirmButtonVariant.success:
        return AppColors.tealPressed;
      case ConfirmButtonVariant.error:
        return AppColors.error.withAlpha(28);
      case ConfirmButtonVariant.alert:
        return AppColors.gold.withAlpha(44);
    }
  }

  void _handleTap() {
    if (_confirming) {
      setState(() => _confirming = false);
      widget.onConfirmed();
    } else {
      setState(() => _confirming = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final variantColor = _variantColor(widget.variant);
    final variantAccent = _variantAccent(widget.variant);

    return ElevatedButton(
      style: AppDecorations.actionButtonStyle(
        backgroundColor: _confirming ? variantColor : variantAccent,
        foregroundColor: _confirming ? Colors.white : variantColor,
        borderColor: _confirming ? null : variantColor.withAlpha(48),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      onPressed: _handleTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: [...previousChildren, ?currentChild],
          );
        },
        transitionBuilder: (child, animation) {
          final scaleAnimation = Tween<double>(
            begin: 0.96,
            end: 1,
          ).animate(animation);

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(_confirming),
          child: _confirming
              ? (widget.confirmWidget ?? Text(l10n.confirmDelete))
              : (widget.initialWidget ?? Text(l10n.delete)),
        ),
      ),
    );
  }
}

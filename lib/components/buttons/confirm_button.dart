import 'package:flutter/material.dart';

enum ConfirmButtonVariant { success, error, alert }

class ConfirmButton extends StatefulWidget {
  final VoidCallback onConfirmed;
  final Widget initialWidget;
  final Widget confirmWidget;
  final ConfirmButtonVariant variant;

  const ConfirmButton({
    super.key,
    required this.onConfirmed,
    this.initialWidget = const Text('Delete'),
    this.confirmWidget = const Text('Confirm'),
    this.variant = ConfirmButtonVariant.error,
  });

  Null get variantColors => null;
  Null get accentColors => null;

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  bool _confirming = false;
  final variantColors = {
    ConfirmButtonVariant.success: Colors.green,
    ConfirmButtonVariant.error: Colors.red,
    ConfirmButtonVariant.alert: Colors.orange,
  };
  final accentColors = {
    ConfirmButtonVariant.success: Colors.green[200]!,
    ConfirmButtonVariant.error: Colors.red[200]!,
    ConfirmButtonVariant.alert: Colors.orange[200]!,
  };

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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _confirming
            ? variantColors[widget.variant]
            : accentColors[widget.variant],
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
          child: _confirming ? widget.confirmWidget : widget.initialWidget,
        ),
      ),
    );
  }
}

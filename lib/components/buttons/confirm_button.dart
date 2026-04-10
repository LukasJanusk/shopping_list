import 'package:flutter/material.dart';

class ConfirmButton extends StatefulWidget {
  final VoidCallback onConfirmed;
  final Widget initialWidget;
  final Widget confirmWidget;
  final Color initialColor;
  final Color confirmColor;

  const ConfirmButton({
    super.key,
    required this.onConfirmed,
    this.initialWidget = const Text('Delete'),
    this.confirmWidget = const Text('Confirm'),
    this.initialColor = Colors.redAccent,
    this.confirmColor = Colors.red,
  });

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  bool _confirming = false;

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
            ? widget.confirmColor
            : widget.initialColor,
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

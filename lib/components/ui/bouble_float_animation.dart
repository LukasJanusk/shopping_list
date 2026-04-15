import 'package:flutter/material.dart';

class BoubleFloatAnimation extends StatefulWidget {
  const BoubleFloatAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 8),
    this.alignment = Alignment.center,
    this.curve = Curves.linear,
    this.offset = Offset.zero,
    this.initialProgress = 0,
  });

  final Widget child;
  final Duration duration;
  final Alignment alignment;
  final Curve curve;
  final Offset offset;
  final double initialProgress;

  @override
  State<BoubleFloatAnimation> createState() => _BoubleFloatAnimationState();
}

class _BoubleFloatAnimationState extends State<BoubleFloatAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..value = widget.initialProgress.clamp(0.0, 1.0)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant BoubleFloatAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration ||
        oldWidget.initialProgress != widget.initialProgress) {
      _controller
        ..duration = widget.duration
        ..value = widget.initialProgress.clamp(0.0, 1.0)
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewportHeight = constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : MediaQuery.sizeOf(context).height;
          final verticalAnimation = CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          );

          return ClipRect(
            child: AnimatedBuilder(
              animation: verticalAnimation,
              child: widget.child,
              builder: (context, child) {
                final y = Tween<double>(
                  begin: viewportHeight + 120,
                  end: -(viewportHeight + 120),
                ).transform(verticalAnimation.value);

                return Align(
                  alignment: widget.alignment,
                  child: Transform.translate(
                    offset: Offset(widget.offset.dx, y + widget.offset.dy),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

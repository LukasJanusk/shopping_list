import 'package:flutter/material.dart';
import 'package:shopping_list/theme/color_theme.dart';

class FloatingTextWithPointer extends StatefulWidget {
  const FloatingTextWithPointer({
    super.key,
    required this.text,
    this.right = 16,
    this.bottom = 112,
    this.duration = const Duration(milliseconds: 1000),
  });

  final String text;
  final double right;
  final double bottom;
  final Duration duration;

  @override
  State<FloatingTextWithPointer> createState() =>
      _FloatingTextWithPointerState();
}

class _FloatingTextWithPointerState extends State<FloatingTextWithPointer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arrowOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _arrowOpacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: widget.right,
      bottom: widget.bottom,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 170),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FadeTransition(
              opacity: _arrowOpacity,
              child: Transform.translate(
                offset: const Offset(-4, 6),
                child: Icon(Icons.south, size: 50, color: AppColors.coral),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

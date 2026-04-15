import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_item_model.dart';
import 'package:shopping_list/theme/app_decorations.dart';
import 'package:shopping_list/theme/color_theme.dart';

class ShoppingListCheckItem extends StatelessWidget {
  const ShoppingListCheckItem({
    super.key,
    required this.item,
    required this.visualChecked,
    required this.isAnimatingCheckmark,
    required this.onTap,
    required this.checkmarkAnimationDuration,
  });

  final ShoppingListItemModel item;
  final bool visualChecked;
  final bool isAnimatingCheckmark;
  final VoidCallback onTap;
  final Duration checkmarkAnimationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBorderColor = visualChecked
        ? AppColors.teal.withAlpha(44)
        : AppColors.inkSoft.withAlpha(24);
    final quantityBadgeColor = visualChecked
        ? AppColors.teal.withAlpha(12)
        : AppColors.canvas;

    return DecoratedBox(
      decoration: AppDecorations.elevatedCard(
        shadows: const [],
        color: AppColors.surface,
        borderColor: cardBorderColor,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppDecorations.cardRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isAnimatingCheckmark ? null : onTap,
          splashColor: AppColors.tealPressed,
          highlightColor: AppColors.teal.withAlpha(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: IgnorePointer(
                    child: _AnimatedCheckmark(
                      checked: visualChecked,
                      activeColor: AppColors.teal,
                      inactiveColor: AppColors.ink.withAlpha(22),
                      duration: checkmarkAnimationDuration,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: visualChecked
                              ? AppColors.inkSoft
                              : AppColors.ink,
                          fontWeight: FontWeight.w700,
                          decoration: visualChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: AppColors.teal.withAlpha(120),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: quantityBadgeColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: visualChecked
                          ? AppColors.teal.withAlpha(28)
                          : AppColors.inkSoft.withAlpha(24),
                    ),
                  ),
                  child: Text(
                    'x${item.quantity}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: visualChecked ? AppColors.teal : AppColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
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

class _AnimatedCheckmark extends StatelessWidget {
  const _AnimatedCheckmark({
    required this.checked,
    required this.activeColor,
    required this.inactiveColor,
    required this.duration,
  });

  final bool checked;
  final Color activeColor;
  final Color inactiveColor;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: checked ? 1 : 0),
      duration: duration,
      curve: Curves.easeInOutCubic,
      builder: (context, progress, child) {
        return CustomPaint(
          painter: _CheckmarkPainter(
            progress: progress,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          ),
        );
      },
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  const _CheckmarkPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    if (progress < 1) {
      final hintPath = Path()
        ..moveTo(size.width * 0.18, size.height * 0.52)
        ..lineTo(size.width * 0.40, size.height * 0.74)
        ..lineTo(size.width * 0.82, size.height * 0.26);
      canvas.drawPath(hintPath, inactivePaint);
    }

    if (progress <= 0) return;

    final start = Offset(size.width * 0.18, size.height * 0.52);
    final middle = Offset(size.width * 0.40, size.height * 0.74);
    final end = Offset(size.width * 0.82, size.height * 0.26);
    final firstSegmentPortion = 0.42;
    final path = Path()..moveTo(start.dx, start.dy);

    if (progress <= firstSegmentPortion) {
      final segmentProgress = progress / firstSegmentPortion;
      path.lineTo(
        start.dx + ((middle.dx - start.dx) * segmentProgress),
        start.dy + ((middle.dy - start.dy) * segmentProgress),
      );
    } else {
      path.lineTo(middle.dx, middle.dy);
      final segmentProgress =
          (progress - firstSegmentPortion) / (1 - firstSegmentPortion);
      path.lineTo(
        middle.dx + ((end.dx - middle.dx) * segmentProgress),
        middle.dy + ((end.dy - middle.dy) * segmentProgress),
      );
    }

    canvas.drawPath(path, activePaint);
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}

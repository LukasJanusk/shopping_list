import 'package:flutter/material.dart';
import 'package:shopping_list/theme/color_theme.dart';

class AppInfoChip extends StatelessWidget {
  const AppInfoChip({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor = AppColors.canvas,
    this.iconColor = AppColors.teal,
    this.textColor = AppColors.ink,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.radius = 18,
    this.iconSize = 18,
    this.spacing = 8,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double iconSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? AppColors.inkSoft.withAlpha(24),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          SizedBox(width: spacing),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

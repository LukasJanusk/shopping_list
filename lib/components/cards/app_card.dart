import 'package:flutter/material.dart';
import 'package:shopping_list/theme/app_decorations.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.width = 120,
    this.height = 120,
    this.onTap,
    this.color,
    this.elevation = 2,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.all(12),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.splashColor,
  });

  final Widget child;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final Color? color;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: AppDecorations.elevatedCard(
          color: color ?? theme.colorScheme.surface,
          borderRadius: borderRadius,
          depth: elevation,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            hoverColor: backgroundColor ?? theme.scaffoldBackgroundColor,
            splashColor: splashColor ?? theme.colorScheme.primary.withAlpha(50),
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

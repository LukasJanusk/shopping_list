import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.size = 120,
    this.onTap,
    this.color,
    this.elevation = 2,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.all(12),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
  });

  final Widget child;
  final double size;
  final VoidCallback? onTap;
  final Color? color;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      width: size,
      height: size,
      child: Material(
        color: color ?? theme.colorScheme.surface,
        elevation: elevation,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          hoverColor: backgroundColor ?? theme.scaffoldBackgroundColor,
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

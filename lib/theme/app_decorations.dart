import 'package:flutter/material.dart';

class AppDecorations {
  static const double cardRadiusValue = 24;
  static const BorderRadius cardRadius = BorderRadius.all(
    Radius.circular(cardRadiusValue),
  );
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(18),
  );

  static List<BoxShadow> elevatedShadow([double depth = 1]) {
    final normalizedDepth = depth.clamp(0.5, 3.0);

    return [
      BoxShadow(
        color: const Color(
          0x1A163138,
        ).withValues(alpha: 0.10 + (0.03 * normalizedDepth)),
        blurRadius: 14 + (4 * normalizedDepth),
        offset: Offset(0, 6 + (4 * normalizedDepth)),
      ),
    ];
  }

  static BoxDecoration elevatedCard({
    required Color color,
    BorderRadius borderRadius = cardRadius,
    Color borderColor = const Color(0x14163138),
    double depth = 1,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: Border.all(color: borderColor),
      boxShadow: shadows ?? elevatedShadow(depth),
    );
  }

  static ButtonStyle actionButtonStyle({
    required Color backgroundColor,
    required Color foregroundColor,
    Color? borderColor,
    double radius = 18,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    double elevation = 0,
    Color shadowColor = Colors.transparent,
    TextStyle? textStyle,
  }) {
    return ElevatedButton.styleFrom(
      elevation: elevation,
      shadowColor: shadowColor,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      textStyle: textStyle,
      side: borderColor == null ? null : BorderSide(color: borderColor),
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

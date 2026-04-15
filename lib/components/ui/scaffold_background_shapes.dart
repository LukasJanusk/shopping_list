import 'package:flutter/material.dart';
import 'package:shopping_list/components/ui/background_circle.dart';
import 'package:shopping_list/theme/color_theme.dart';

class ScaffoldBackgroundShapes extends StatelessWidget {
  const ScaffoldBackgroundShapes({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return IgnorePointer(
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: 12,
              right: -56,
              child: BackgroundCircle(
                size: 176,
                color: AppColors.coral.withAlpha(12),
              ),
            ),
            Positioned(
              top: 148,
              left: -42,
              child: BackgroundCircle(
                size: 108,
                color: AppColors.teal.withAlpha(12),
              ),
            ),
            Positioned(
              bottom: -64,
              left: 28,
              child: BackgroundCircle(
                size: 148,
                color: AppColors.gold.withAlpha(12),
              ),
            ),
            Positioned(
              bottom: 300,
              right: 110,
              child: BackgroundCircle(
                size: 42,
                color: AppColors.teal.withAlpha(12),
              ),
            ),
            Positioned(
              bottom: 500,
              right: 220,
              child: BackgroundCircle(
                size: 62,
                color: AppColors.gold.withAlpha(12),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 120,
              child: BackgroundCircle(
                size: 42,
                color: AppColors.coral.withAlpha(12),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              right: 20,
              child: BackgroundCircle(
                size: screenHeight * 0.2,
                color: AppColors.coral.withAlpha(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

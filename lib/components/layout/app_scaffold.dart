import 'package:flutter/material.dart';
import 'package:shopping_list/components/ui/scaffold_background_shapes.dart';
import 'package:shopping_list/theme/color_theme.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.showShapes = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool showShapes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.canvas,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          if (showShapes)
            const Positioned.fill(child: ScaffoldBackgroundShapes()),
          body,
        ],
      ),
    );
  }
}

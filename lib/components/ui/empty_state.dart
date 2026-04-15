import 'package:flutter/material.dart';
import 'package:shopping_list/theme/color_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_list/theme/app_assets.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.asset = AppAssets.emptyLists,
    this.title,
    this.subtitle,
  });

  final String asset;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(asset, height: 200),
        const SizedBox(height: 24),
        if (title != null)
          Text(
            title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        const SizedBox(height: 10),
        if (subtitle != null)
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.inkSoft,
              height: 1.4,
            ),
          ),
      ],
    );
  }
}

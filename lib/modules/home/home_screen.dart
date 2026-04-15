import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_list/components/cards/app_card.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/theme/app_assets.dart';
import 'package:shopping_list/theme/color_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      showShapes: false,
      appBar: AppTopBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SvgPicture.asset(AppAssets.appMark, width: 30, height: 30),
            const SizedBox(width: 12),
            const Text('Shopping List'),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const screenPadding = 16.0;
            const minCardHeight = 88.0;
            const maxCardHeight = 144.0;
            const minSmallCardHeight = 82.0;
            const maxSmallCardHeight = 110.0;
            const maxHeroHeight = 230.0;

            final isCompactHeight = constraints.maxHeight < 760;
            final heroGap = isCompactHeight ? 12.0 : 16.0;
            final actionGap = isCompactHeight ? 12.0 : 16.0;
            final sectionGap = isCompactHeight ? 20.0 : 28.0;

            final titleStyle = theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            );
            final bodyStyle = theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.inkSoft,
              height: 1.4,
            );

            double measureTextHeight(String text, TextStyle? style) {
              final painter = TextPainter(
                text: TextSpan(text: text, style: style),
                textDirection: Directionality.of(context),
                textScaler: MediaQuery.textScalerOf(context),
              )..layout(maxWidth: constraints.maxWidth - (screenPadding * 2));

              return painter.height;
            }

            const title = 'Plan faster. Shop calmer.';
            const description =
                'Create a list, keep track of every item, and head to the store with a clear plan.';

            final titleHeight = measureTextHeight(title, titleStyle);
            final bodyHeight = measureTextHeight(description, bodyStyle);
            final fixedHeight =
                (screenPadding * 2) +
                titleHeight +
                bodyHeight +
                heroGap +
                10 +
                sectionGap +
                (actionGap * 2);
            final availableForHeroAndCards = max(
              0.0,
              constraints.maxHeight - fixedHeight,
            );

            final preferredHeroHeight = min(
              maxHeroHeight,
              constraints.maxHeight * (isCompactHeight ? 0.2 : 0.28),
            );
            final heroHeight = min(
              preferredHeroHeight,
              max(
                0.0,
                availableForHeroAndCards -
                    ((minCardHeight * 2) + minSmallCardHeight),
              ),
            );
            final remainingCardSpace = max(
              0.0,
              availableForHeroAndCards - heroHeight,
            );
            final smallCardHeight = (remainingCardSpace * 0.28)
                .clamp(minSmallCardHeight, maxSmallCardHeight)
                .toDouble();
            final largeCardHeight = ((remainingCardSpace - smallCardHeight) / 2)
                .clamp(minCardHeight, maxCardHeight)
                .toDouble();

            return Padding(
              padding: const EdgeInsets.all(screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (heroHeight > 0)
                    SvgPicture.asset(AppAssets.homeHero, height: heroHeight),
                  if (heroHeight > 0) SizedBox(height: heroGap),
                  Text(title, textAlign: TextAlign.center, style: titleStyle),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: bodyStyle,
                  ),
                  SizedBox(height: sectionGap),
                  AppCard(
                    width: double.infinity,
                    height: largeCardHeight,
                    color: AppColors.coral,
                    splashColor: AppColors.coralPressed,
                    onTap: () => Navigator.pushNamed(context, '/create-list'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.playlist_add_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Create New List',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: actionGap),
                  AppCard(
                    width: double.infinity,
                    height: largeCardHeight,
                    color: AppColors.teal,
                    splashColor: AppColors.tealPressed,
                    onTap: () =>
                        Navigator.pushNamed(context, '/select-shopping-list'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.shopping_bag_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Go Shopping',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: actionGap),
                  Row(
                    children: [
                      Expanded(
                        child: AppCard(
                          width: double.infinity,
                          height: smallCardHeight,
                          color: AppColors.canvas,
                          splashColor: AppColors.coralPressed,
                          onTap: () => Navigator.pushNamed(context, '/history'),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.history_rounded,
                                size: 28,
                                color: AppColors.ink,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'History',
                                style: TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: actionGap),
                      Expanded(
                        child: AppCard(
                          width: double.infinity,
                          height: smallCardHeight,
                          color: AppColors.canvas,
                          splashColor: AppColors.tealPressed,
                          onTap: () =>
                              Navigator.pushNamed(context, '/statistics'),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.insert_chart_rounded,
                                size: 28,
                                color: AppColors.ink,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Statistics',
                                style: TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

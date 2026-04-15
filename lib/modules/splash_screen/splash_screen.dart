import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/ui/background_circle.dart';
import 'package:shopping_list/components/ui/bouble_float_animation.dart';
import 'package:shopping_list/theme/app_assets.dart';
import 'package:shopping_list/theme/color_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  bool _showCartIcon = false;
  bool _showEnterHint = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<double>(
      begin: 14,
      end: -6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _scaleAnimation = Tween<double>(
      begin: 0.98,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future<void>.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _showCartIcon = true;
      });
    });

    Future<void>.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _showEnterHint = true;
      });
    });
  }

  void _enterHomePage() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      appBar: null,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _enterHomePage,
        child: Stack(
          children: [
            BoubleFloatAnimation(
              alignment: Alignment.bottomLeft,
              offset: const Offset(36, 0),
              duration: const Duration(seconds: 15),
              initialProgress: 0.18,
              child: BackgroundCircle(
                size: 96,
                color: AppColors.coral.withAlpha(38),
              ),
            ),
            BoubleFloatAnimation(
              alignment: Alignment.bottomRight,
              offset: const Offset(-42, 120),
              duration: const Duration(seconds: 20),
              initialProgress: 0.42,
              child: BackgroundCircle(
                size: 132,
                color: AppColors.teal.withAlpha(28),
              ),
            ),
            BoubleFloatAnimation(
              alignment: Alignment.bottomCenter,
              offset: const Offset(-96, 220),
              duration: const Duration(seconds: 16),
              initialProgress: 0.68,
              child: BackgroundCircle(
                size: 54,
                color: AppColors.gold.withAlpha(44),
              ),
            ),
            BoubleFloatAnimation(
              alignment: Alignment.bottomCenter,
              offset: const Offset(110, 60),
              duration: const Duration(seconds: 16),
              initialProgress: 0.3,
              child: BackgroundCircle(
                size: 76,
                color: AppColors.info.withAlpha(30),
              ),
            ),
            BoubleFloatAnimation(
              alignment: Alignment.bottomLeft,
              offset: const Offset(140, 280),
              duration: const Duration(seconds: 12),
              initialProgress: 0.84,
              child: BackgroundCircle(
                size: 160,
                color: AppColors.tealPressed.withAlpha(48),
              ),
            ),
            BoubleFloatAnimation(
              alignment: Alignment.bottomRight,
              offset: const Offset(-120, 340),
              duration: const Duration(seconds: 16),
              initialProgress: 0.56,
              child: BackgroundCircle(
                size: 44,
                color: AppColors.coralPressed.withAlpha(54),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: 0.55 + (_fadeAnimation.value * 0.45),
                        child: child,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.ink,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'to Shopping List',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.inkSoft,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 450),
                      curve: Curves.easeOutCubic,
                      opacity: _showCartIcon ? 1 : 0,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 450),
                        curve: Curves.easeOutCubic,
                        offset: _showCartIcon
                            ? Offset.zero
                            : const Offset(0, 0.2),
                        child: SvgPicture.asset(
                          AppAssets.shoppingCartSplash,
                          width: 88,
                          height: 88,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                minimum: const EdgeInsets.only(bottom: 28),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: _showEnterHint ? 1 : 0,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 350),
                    offset: _showEnterHint
                        ? Offset.zero
                        : const Offset(0, 0.25),
                    curve: Curves.easeOutCubic,
                    child: Text(
                      'Tap to start',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.inkSoft,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

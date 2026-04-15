import 'package:flutter/material.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/theme/color_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      appBar: AppTopBar(title: Text(l10n.settings)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.settings_rounded,
                size: 56,
                color: AppColors.inkSoft,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.settingsPlaceholder,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: AppColors.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list/components/form/app_dropdown_setting_select.dart';
import 'package:shopping_list/components/layout/app_scaffold.dart';
import 'package:shopping_list/components/layout/app_top_bar.dart';
import 'package:shopping_list/core/settings.dart';
import 'package:shopping_list/l10n/l10n.dart';
import 'package:shopping_list/theme/color_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.settings});

  final Settings settings;

  Future<void> _changeLanguage(Locale? newLocale) async {
    if (newLocale == null) return;
    await settings.setLocale(newLocale);
  }

  String _localeLabel(BuildContext context, Locale locale) {
    final l10n = context.l10n;

    switch (locale.languageCode) {
      case 'lt':
        return l10n.languageLithuanian;
      case 'en':
        return l10n.languageEnglish;
      default:
        return locale.languageCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      showShapes: true,
      appBar: AppTopBar(
        title: Row(
          children: [
            Icon(Icons.settings_rounded, size: 24, color: AppColors.inkSoft),
            SizedBox(width: 8),
            Text(l10n.settings),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedBuilder(
          animation: settings,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.language,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(color: AppColors.ink),
                    ),
                    const Spacer(),
                    AppDropdownSettingSelect<Locale>(
                      items: Settings.supportedLocales
                          .map(
                            (locale) => DropdownMenuItem<Locale>(
                              alignment: AlignmentDirectional.centerEnd,
                              value: locale,
                              child: Text(_localeLabel(context, locale)),
                            ),
                          )
                          .toList(),
                      value: settings.locale,
                      onChanged: _changeLanguage,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:shopping_list/core/storage_manager.dart';
import 'package:shopping_list/l10n/app_localizations.dart';

class Settings extends ChangeNotifier {
  Settings({Locale? locale})
    : _locale = _resolveSupportedLocale(locale ?? _defaultLocale);

  static const Locale _defaultLocale = Locale('lt');
  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  Locale _locale;
  Locale get locale => _locale;

  Future<void> initialize() async {
    await loadPreferredLocale();
  }

  Future<void> loadPreferredLocale() async {
    final savedLanguageCode = StorageManager.getString(
      StorageKeys.preferredLocale.key,
    );

    if (savedLanguageCode == null || savedLanguageCode.isEmpty) {
      return;
    }

    final resolvedLocale = _resolveSupportedLocale(Locale(savedLanguageCode));

    if (_locale == resolvedLocale) {
      return;
    }

    _locale = resolvedLocale;
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    final resolvedLocale = _resolveSupportedLocale(newLocale);

    if (_locale == resolvedLocale) {
      return;
    }

    _locale = resolvedLocale;
    await StorageManager.saveString(
      StorageKeys.preferredLocale.key,
      resolvedLocale.languageCode,
    );
    notifyListeners();
  }

  static Locale _resolveSupportedLocale(Locale locale) {
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    throw ArgumentError('Unsupported locale: $locale');
  }
}

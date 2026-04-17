import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_list/core/settings.dart';
import 'package:shopping_list/core/storage_manager.dart';
import 'package:shopping_list/l10n/app_localizations.dart';
import 'package:shopping_list/modules/home/home_screen.dart';
import 'package:shopping_list/modules/history/history_screen.dart';
import 'package:shopping_list/modules/settings/settings_screen.dart';
import 'package:shopping_list/modules/shopping_list/shopping/select_shopping_list_screen.dart';
import 'package:shopping_list/modules/shopping_list/shopping/shopping_screen.dart';
import 'package:shopping_list/modules/splash_screen/splash_screen.dart';
import 'package:shopping_list/modules/statistics/statistics_screen.dart';
import 'package:shopping_list/theme/color_theme.dart';
import 'modules/shopping_list/create_list/shopping_list_screen.dart';
import 'modules/shopping_list/create_list/shopping_list_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await StorageManager.init();
  final settings = Settings();
  await settings.initialize();
  runApp(MainApp(settings: settings));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.settings});

  final Settings settings;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    widget.settings.addListener(_handleSettingsChanged);
  }

  @override
  void dispose() {
    widget.settings.removeListener(_handleSettingsChanged);
    super.dispose();
  }

  void _handleSettingsChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      locale: widget.settings.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/splash',
      routes: {
        '/': (context) => const HomeScreen(),
        '/splash': (context) => const SplashScreen(),
        '/create-list': (context) => const ShoppingListScreen(),
        '/select-shopping-list': (context) => const SelectShoppingListScreen(),
        '/shopping-list-info': (context) => const ShoppingListInfoScreen(),
        '/shopping': (context) => const ShoppingScreen(),
        '/history': (context) => const HistoryScreen(),
        '/statistics': (context) => const StatisticsScreen(),
        '/settings': (context) => SettingsScreen(settings: widget.settings),
      },
    );
  }
}

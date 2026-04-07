import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/models/storage_manager.dart';
import 'modules/shopping-list/shopping_list_screen.dart';
import 'modules/shopping-list/shopping_list_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const ShoppingListScreen(),
        '/info': (context) => const ShoppingListInfoScreen(),
      },
    );
  }
}

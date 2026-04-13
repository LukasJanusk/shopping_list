import 'package:flutter/material.dart';
import 'package:shopping_list/modules/home/home_screen.dart';
import 'package:shopping_list/modules/shopping_list/models/storage_manager.dart';
import 'package:shopping_list/modules/shopping_list/shopping/select_shopping_list_screen.dart';
import 'package:shopping_list/modules/shopping_list/shopping/shopping_screen.dart';
import 'modules/shopping_list/create_list/shopping_list_screen.dart';
import 'modules/shopping_list/create_list/shopping_list_info_screen.dart';

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
        '/': (context) => const HomeScreen(),
        '/create-list': (context) => const ShoppingListScreen(),
        '/select-shopping-list': (context) => const SelectShoppingListScreen(),
        '/shopping-list-info': (context) => const ShoppingListInfoScreen(),
        '/shopping': (context) => const ShoppingScreen(),
      },
    );
  }
}

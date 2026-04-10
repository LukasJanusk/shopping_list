import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_list/components/cards/app_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final screenHeight = mediaQuery.size.height;
    final safeTop = mediaQuery.padding.top;
    final safeBottom = mediaQuery.padding.bottom;
    final appBarHeight = AppBar().preferredSize.height;
    final usableHeight = screenHeight - safeTop - safeBottom - appBarHeight;

    final cardSize = min(usableHeight * 0.3, 200.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            AppCard(
              width: cardSize,
              height: cardSize,
              color: Colors.blueAccent,
              onTap: () => Navigator.pushNamed(context, '/create-list'),
              child: const Text(
                'Create New List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppCard(
              width: cardSize,
              height: cardSize,
              color: Colors.indigo,
              onTap: () => Navigator.pushNamed(context, '/shopping'),
              child: const Text(
                'Go Shopping',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';

class SelectShoppingListCard extends StatelessWidget {
  const SelectShoppingListCard({
    super.key,
    required this.list,
    required this.onTap,
  });

  final ShoppingListModel list;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: Material(
        color: Colors.amber,
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          hoverColor: Colors.amber[200],
          splashColor: Colors.amber[900],
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                list.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

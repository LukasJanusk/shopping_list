import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_model.dart';

class ShoppingListItemWidget extends StatelessWidget {
  const ShoppingListItemWidget({super.key, required this.list});

  final ShoppingListModel list;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(list.name),
          Spacer(),
          Text(
            '${list.items.length} items',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/info', arguments: list);
      },
    );
  }
}

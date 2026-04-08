import 'package:flutter/material.dart';
import 'package:shopping_list/modules/shopping-list/models/shopping_list_model.dart';

class ShoppingListItemWidget extends StatelessWidget {
  const ShoppingListItemWidget({
    super.key,
    required this.list,
    required this.onTap,
  });

  final ShoppingListModel list;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(list.name),
          Spacer(),

          Text(
            '${list.items.length} items',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 24),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

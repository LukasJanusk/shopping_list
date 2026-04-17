import 'package:shopping_list/modules/shopping_list/models/shopping_list_model.dart';

class HistoryDaySection {
  HistoryDaySection({
    required this.date,
    required this.title,
    required this.lists,
  });

  final DateTime date;
  final String title;
  final List<ShoppingListModel> lists;
}

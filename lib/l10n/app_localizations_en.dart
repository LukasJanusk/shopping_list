// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Shopping List';

  @override
  String get homeHeroTitle => 'Plan faster. Shop calmer.';

  @override
  String get homeHeroDescription =>
      'Create a list, keep track of every item, and head to the store with a clear plan.';

  @override
  String get createNewList => 'Create New List';

  @override
  String get goShopping => 'Go Shopping';

  @override
  String get history => 'History';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get welcome => 'Welcome';

  @override
  String get splashSubtitle => 'to Shopping List';

  @override
  String get tapToStart => 'Tap to start';

  @override
  String get shoppingLists => 'Shopping Lists';

  @override
  String get noShoppingListsYet => 'No shopping lists yet';

  @override
  String get emptyListsDescription =>
      'Start with a fresh list and keep everything you need in one place.';

  @override
  String get tapCreateFirstList => 'Tap + to create your first list!';

  @override
  String get selectShoppingList => 'Select Shopping List';

  @override
  String get createYourFirstList => 'Create Your First List';

  @override
  String get newListDefaultName => 'New List';

  @override
  String get deleteItemTitle => 'Delete item?';

  @override
  String deleteItemMessage(Object itemName) {
    return 'Remove \"$itemName\" from this shopping list? This action cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get editListTitle => 'Edit List Title';

  @override
  String get listTitle => 'List Title';

  @override
  String get enterListTitle => 'Enter list title';

  @override
  String get deleteList => 'Delete list';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get save => 'Save';

  @override
  String get yourListIsEmpty => 'Your list is empty';

  @override
  String get tapAddItemsToList => 'Tap + to add items to your list!';

  @override
  String get editItemName => 'Edit Item Name';

  @override
  String get itemName => 'Item Name';

  @override
  String get enterItemName => 'Enter item name';

  @override
  String get updateList => 'Update List';

  @override
  String get updateListTitle => 'Update List Title';

  @override
  String get update => 'Update';

  @override
  String get fieldCannotBeEmpty => 'Field cannot be empty';

  @override
  String get createListTitle => 'Create New List';

  @override
  String get listName => 'List Name';

  @override
  String get enterListName => 'Enter list name';

  @override
  String get pleaseEnterListName => 'Please enter a list name';

  @override
  String get createList => 'Create List';

  @override
  String get addItemToList => 'Add item to list';

  @override
  String get pleaseEnterItemName => 'Please enter an item name';

  @override
  String get quantity => 'Quantity';

  @override
  String get addItem => 'Add Item';

  @override
  String get shopping => 'Shopping';

  @override
  String get noShoppingListSelected => 'No shopping list selected.';

  @override
  String get checked => 'Checked';

  @override
  String get unchecked => 'Unchecked';

  @override
  String get noCheckedItemsYet => 'No checked items yet.';

  @override
  String get noUncheckedItems => 'No unchecked items.';

  @override
  String get finishShoppingTitle => 'Finish shopping?';

  @override
  String get finishShoppingMessage =>
      'Mark this shopping trip as completed? You can still review it later in history.';

  @override
  String get finish => 'Finish';

  @override
  String get shoppingHistory => 'Shopping History';

  @override
  String get shoppingHistoryPlaceholder => 'Shopping history will appear here.';

  @override
  String get settingsPlaceholder => 'Settings will appear here.';

  @override
  String get statisticsPlaceholder => 'Statistics will appear here.';

  @override
  String get cancel => 'Cancel';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }
}

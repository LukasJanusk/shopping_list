import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_lt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('lt'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Shopping List'**
  String get appName;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan faster. Shop calmer.'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a list, keep track of every item, and head to the store with a clear plan.'**
  String get homeHeroDescription;

  /// No description provided for @createNewList.
  ///
  /// In en, this message translates to:
  /// **'Create New List'**
  String get createNewList;

  /// No description provided for @goShopping.
  ///
  /// In en, this message translates to:
  /// **'Go Shopping'**
  String get goShopping;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'to Shopping List'**
  String get splashSubtitle;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to start'**
  String get tapToStart;

  /// No description provided for @shoppingLists.
  ///
  /// In en, this message translates to:
  /// **'Shopping Lists'**
  String get shoppingLists;

  /// No description provided for @noShoppingListsYet.
  ///
  /// In en, this message translates to:
  /// **'No shopping lists yet'**
  String get noShoppingListsYet;

  /// No description provided for @emptyListsDescription.
  ///
  /// In en, this message translates to:
  /// **'Start with a fresh list and keep everything you need in one place.'**
  String get emptyListsDescription;

  /// No description provided for @tapCreateFirstList.
  ///
  /// In en, this message translates to:
  /// **'Tap + to create your first list!'**
  String get tapCreateFirstList;

  /// No description provided for @selectShoppingList.
  ///
  /// In en, this message translates to:
  /// **'Select Shopping List'**
  String get selectShoppingList;

  /// No description provided for @createYourFirstList.
  ///
  /// In en, this message translates to:
  /// **'Create Your First List'**
  String get createYourFirstList;

  /// No description provided for @newListDefaultName.
  ///
  /// In en, this message translates to:
  /// **'New List'**
  String get newListDefaultName;

  /// No description provided for @deleteItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete item?'**
  String get deleteItemTitle;

  /// No description provided for @deleteItemMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{itemName}\" from this shopping list? This action cannot be undone.'**
  String deleteItemMessage(Object itemName);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @editListTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit List Title'**
  String get editListTitle;

  /// No description provided for @listTitle.
  ///
  /// In en, this message translates to:
  /// **'List Title'**
  String get listTitle;

  /// No description provided for @enterListTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter list title'**
  String get enterListTitle;

  /// No description provided for @deleteList.
  ///
  /// In en, this message translates to:
  /// **'Delete list'**
  String get deleteList;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @yourListIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your list is empty'**
  String get yourListIsEmpty;

  /// No description provided for @tapAddItemsToList.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add items to your list!'**
  String get tapAddItemsToList;

  /// No description provided for @editItemName.
  ///
  /// In en, this message translates to:
  /// **'Edit Item Name'**
  String get editItemName;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @enterItemName.
  ///
  /// In en, this message translates to:
  /// **'Enter item name'**
  String get enterItemName;

  /// No description provided for @updateList.
  ///
  /// In en, this message translates to:
  /// **'Update List'**
  String get updateList;

  /// No description provided for @updateListTitle.
  ///
  /// In en, this message translates to:
  /// **'Update List Title'**
  String get updateListTitle;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field cannot be empty'**
  String get fieldCannotBeEmpty;

  /// No description provided for @createListTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New List'**
  String get createListTitle;

  /// No description provided for @listName.
  ///
  /// In en, this message translates to:
  /// **'List Name'**
  String get listName;

  /// No description provided for @enterListName.
  ///
  /// In en, this message translates to:
  /// **'Enter list name'**
  String get enterListName;

  /// No description provided for @pleaseEnterListName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a list name'**
  String get pleaseEnterListName;

  /// No description provided for @createList.
  ///
  /// In en, this message translates to:
  /// **'Create List'**
  String get createList;

  /// No description provided for @addItemToList.
  ///
  /// In en, this message translates to:
  /// **'Add item to list'**
  String get addItemToList;

  /// No description provided for @pleaseEnterItemName.
  ///
  /// In en, this message translates to:
  /// **'Please enter an item name'**
  String get pleaseEnterItemName;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @noShoppingListSelected.
  ///
  /// In en, this message translates to:
  /// **'No shopping list selected.'**
  String get noShoppingListSelected;

  /// No description provided for @checked.
  ///
  /// In en, this message translates to:
  /// **'Checked'**
  String get checked;

  /// No description provided for @unchecked.
  ///
  /// In en, this message translates to:
  /// **'Unchecked'**
  String get unchecked;

  /// No description provided for @noCheckedItemsYet.
  ///
  /// In en, this message translates to:
  /// **'No checked items yet.'**
  String get noCheckedItemsYet;

  /// No description provided for @noUncheckedItems.
  ///
  /// In en, this message translates to:
  /// **'No unchecked items.'**
  String get noUncheckedItems;

  /// No description provided for @finishShoppingTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish shopping?'**
  String get finishShoppingTitle;

  /// No description provided for @finishShoppingMessage.
  ///
  /// In en, this message translates to:
  /// **'Mark this shopping trip as completed? You can still review it later in history.'**
  String get finishShoppingMessage;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @shoppingHistory.
  ///
  /// In en, this message translates to:
  /// **'Shopping History'**
  String get shoppingHistory;

  /// No description provided for @shoppingHistoryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Shopping history will appear here.'**
  String get shoppingHistoryPlaceholder;

  /// No description provided for @settingsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Settings will appear here.'**
  String get settingsPlaceholder;

  /// No description provided for @statisticsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Statistics will appear here.'**
  String get statisticsPlaceholder;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageLithuanian.
  ///
  /// In en, this message translates to:
  /// **'Lithuanian'**
  String get languageLithuanian;

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String itemCount(int count);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'lt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'lt':
      return AppLocalizationsLt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

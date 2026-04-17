// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appName => 'Pirkinių sąrašas';

  @override
  String get homeHeroTitle => 'Planuokite greičiau. Apsipirkite ramiau.';

  @override
  String get homeHeroDescription =>
      'Sukurkite sąrašą, pridėkitę prekę ir eikite į parduotuvę turėdami aiškų planą.';

  @override
  String get createNewList => 'Sukurti naują sąrašą';

  @override
  String get goShopping => 'Eiti apsipirkti';

  @override
  String get history => 'Istorija';

  @override
  String get statistics => 'Statistika';

  @override
  String get settings => 'Nustatymai';

  @override
  String get welcome => 'Sveiki atvykę';

  @override
  String get splashSubtitle => 'į Pirkinių sąrašą';

  @override
  String get tapToStart => 'Palieskite, kad pradėtumėte';

  @override
  String get shoppingLists => 'Pirkinių sąrašai';

  @override
  String get noShoppingListsYet => 'Dar nėra pirkinių sąrašų';

  @override
  String get noShoppingLists => 'Pirkinių sąrašų nėra';

  @override
  String get emptyListsDescription =>
      'Pradėkite nuo naujo sąrašo ir laikykite viską, ko reikia, vienoje vietoje.';

  @override
  String get tapCreateFirstList => 'Spauskite +, kad sukurtumėte pirmą sąrašą!';

  @override
  String get selectShoppingList => 'Pasirinkite sąrašą';

  @override
  String get createYourFirstList => 'Sukurkite pirmą sąrašą';

  @override
  String get newListDefaultName => 'Naujas sąrašas';

  @override
  String get deleteItemTitle => 'Ištrinti prekę?';

  @override
  String deleteItemMessage(Object itemName) {
    return 'Pašalinti \"$itemName\" iš šio pirkinių sąrašo? Šio veiksmo atšaukti negalėsite.';
  }

  @override
  String get deleteListTitle => 'Ištrinti sąrašą?';

  @override
  String deleteListMessage(Object listName) {
    return 'Pašalinti \"$listName\" ir visas jo prekes? Šio veiksmo atšaukti negalėsite.';
  }

  @override
  String get delete => 'Ištrinti';

  @override
  String get editListTitle => 'Redaguoti sąrašo pavadinimą';

  @override
  String get listTitle => 'Sąrašo pavadinimas';

  @override
  String get enterListTitle => 'Įveskite sąrašo pavadinimą';

  @override
  String get deleteList => 'Ištrinti sąrašą';

  @override
  String get confirmDelete => 'Patvirtinti ištrynimą';

  @override
  String get save => 'Išsaugoti';

  @override
  String get yourListIsEmpty => 'Jūsų sąrašas tuščias';

  @override
  String get tapAddItemsToList =>
      'Spauskite +, kad pridėtumėte prekių į sąrašą!';

  @override
  String get editItemName => 'Redaguoti prekės pavadinimą';

  @override
  String get itemName => 'Prekės pavadinimas';

  @override
  String get enterItemName => 'Įveskite prekės pavadinimą';

  @override
  String get updateList => 'Atnaujinti sąrašą';

  @override
  String get updateListTitle => 'Atnaujinti sąrašo pavadinimą';

  @override
  String get update => 'Atnaujinti';

  @override
  String get fieldCannotBeEmpty => 'Laukelis negali būti tuščias';

  @override
  String get createListTitle => 'Sukurti naują sąrašą';

  @override
  String get listName => 'Sąrašo pavadinimas';

  @override
  String get myLists => 'Mano sąrašai';

  @override
  String get enterListName => 'Įveskite sąrašo pavadinimą';

  @override
  String get pleaseEnterListName => 'Įveskite sąrašo pavadinimą';

  @override
  String get createList => 'Sukurti sąrašą';

  @override
  String get addItemToList => 'Pridėti prekę į sąrašą';

  @override
  String get pleaseEnterItemName => 'Įveskite prekės pavadinimą';

  @override
  String get quantity => 'Kiekis';

  @override
  String get addItem => 'Pridėti prekę';

  @override
  String get shopping => 'Apsipirkimas';

  @override
  String get noShoppingListSelected => 'Nepasirinktas pirkinių sąrašas.';

  @override
  String get checked => 'Pažymėta';

  @override
  String get unchecked => 'Nepažymėta';

  @override
  String get noCheckedItemsYet => 'Pažymėtų prekių dar nėra.';

  @override
  String get noUncheckedItems => 'Nepažymėtų prekių nėra.';

  @override
  String get finishShoppingTitle => 'Baigti apsipirkimą?';

  @override
  String get finishShoppingMessage =>
      'Pažymėti šį apsipirkimą kaip užbaigtą? Vėliau jį galėsite peržiūrėti istorijoje.';

  @override
  String get finish => 'Baigti';

  @override
  String get shoppingHistory => 'Apsipirkimų istorija';

  @override
  String get shoppingHistoryPlaceholder =>
      'Apsipirkimų istorija bus rodoma čia.';

  @override
  String get purchasedItems => 'Nupirktos prekės';

  @override
  String get noPurchasedItems => 'Šiame sąraše nėra nupirktų prekių.';

  @override
  String completedOn(Object date) {
    return 'Užbaigta $date';
  }

  @override
  String get settingsPlaceholder => 'Nustatymai bus rodomi čia.';

  @override
  String get statisticsPlaceholder => 'Statistika bus rodoma čia.';

  @override
  String get cancel => 'Atšaukti';

  @override
  String get languageEnglish => 'Anglų';

  @override
  String get languageLithuanian => 'Lietuvių';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prekių',
      few: '$count prekės',
      one: '$count prekė',
      zero: 'Nėra prekių',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Kalba';
}

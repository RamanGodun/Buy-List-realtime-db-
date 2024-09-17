import 'package:flutter/cupertino.dart';

class Constants {
  // URL
  static const String _baseUrl =
      'https://study-project-36199-default-rtdb.europe-west1.firebasedatabase.app/';
  static String get baseUrl => _baseUrl;

  // API Endpoints
  static Uri get shoppingListUrl => Uri.https(_baseUrl, 'shopping-list.json');

  // App Details
  static const String appName = 'Shopping List';

  // Timeouts
  static const Duration connectTimeout = Duration(milliseconds: 5000);
  static const Duration receiveTimeout = Duration(milliseconds: 3000);

  // Primary and secondary colors
  static const Color kPrimaryColor = Color(0xFF007AFF); // iOS Blue
  static const Color kSecondaryColor = Color(0xFF34C759); // iOS Green

  // Font sizes
  static const double appBarTitleFontSize = 20.0;
  static const double elevatedButtonFontSize = 16.0;
  static const double titleLargeFontSize = 20.0;
  static const double bodyMediumFontSize = 16.0;
  static const double bodyLargeFontSize = 18.0;
  static const double quantityFontSize = 16.0;
  static const double categoryFontSize = 14.0;
  static const double inputFontSize = 16.0;
  static const double dropdownFontSize = 16.0;

  // Padding and margins
  static const double smallVerticalSpacing = 8.0;
  static const double mediumVerticalSpacing = 12.0;
  static const double smallHorizontalSpacing = 8.0;
  static const double inputVerticalPadding = 12.0;
  static const double inputHorizontalPadding = 16.0;
  static const double dropdownVerticalPadding = 12.0;
  static const double dropdownHorizontalPadding = 16.0;
  static const double elevatedButtonVerticalPadding = 14.0;
  static const double elevatedButtonHorizontalPadding = 20.0;
  static const double buttonPaddingHorizontal = 29.0;

  static const EdgeInsets newItemPadding = EdgeInsets.all(12.0);

  // Border radius
  static const double elevatedButtonBorderRadius = 12.0;
  static const double cardBorderRadius = 15.0;
  static const double inputBorderRadius = 12.0;
  static const double dropdownBorderRadius = 12.0;

  // Elevation
  static const double cardElevation = 2.0;

  // Sizes
  static const double quantityFieldWidth = 100.0;
  static const double elevatedButtonWidth = 200.0;
  static const double categoryCircleSize = 14.0;
  static const double dropdownItemSpacing = 8.0;

  // Progress indicator
  static const double progressIndicatorStrokeWidth = 2.0;

  // Button-related constants
  static const String saveButtonText = 'Save';

  // Floating action button padding
  static const EdgeInsets floatingActionButtonPadding =
      EdgeInsets.only(bottom: 125, right: 19);

  // Colors for various fields
  static const Color dismissibleBackgroundColor = CupertinoColors.systemRed;
  static const Color inputFillColor = Color(0xFFF5F5F5);
  static const Color dropdownFillColor = Color(0xFFF5F5F5);

  // Error messages
  static const String removeItemErrorMessage = 'Failed to delete the item.';
  static const String nameFieldErrorMessage =
      'Must be between 1 and 50 characters.';
  static const String quantityFieldErrorMessage =
      'Must be a valid positive number.';
  static const String nameInputErrorMessage =
      'Must be between 1 and 50 characters.';
  static const String quantityInputErrorMessage =
      'Must be a valid positive number.';

  // Input field labels
  static const String nameFieldLabelText = 'Item to buy:';
  static const String quantityFieldLabelText = 'Quantity';
  static const String nameInputLabel = 'Item to buy:';
  static const String quantityInputLabel = 'Quantity';

  // Name input field settings
  static const int nameInputMaxLength = 50;
  static const int nameInputMinLength = 1;
  static const int nameFieldMaxLength = 50;
  static const int nameFieldMinLength = 1;

  // Titles and messages
  static const String purchaseListTitle = 'Shopping List';
  static const String emptyListMessage = 'Add your first item! 👆🏼';
  static const String addItemTitle = 'Add to Shopping List';

  // Category names
  static const String vegetablesTitle = 'Vegetables';
  static const String fruitTitle = 'Fruit';
  static const String meatTitle = 'Meat';
  static const String dairyTitle = 'Dairy';
  static const String sweetsTitle = 'Sweets';
  static const String convenienceTitle = 'Convenience Foods';
  static const String otherTitle = 'Other';

  // Category colors
  static const Color vegetablesColor = Color.fromARGB(255, 2, 24, 13);
  static const Color fruitColor = Color.fromARGB(255, 123, 222, 2);
  static const Color meatColor = Color.fromARGB(255, 255, 102, 0);
  static const Color dairyColor = Color.fromARGB(255, 49, 217, 255);
  static const Color sweetsColor = Color.fromARGB(255, 252, 147, 1);
  static const Color convenienceColor = Color.fromARGB(255, 249, 255, 162);
  static const Color otherColor = Color.fromARGB(255, 79, 86, 86);
}

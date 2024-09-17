import 'package:flutter/cupertino.dart';

/// This class holds all the constant values used throughout the app,
/// including colors, sizes, padding, and text strings.
/// Centralizing constants in one place helps to maintain consistency
/// and makes it easier to update the app's style or text in the future.

class Constants {
  // Base URL for the Firebase Realtime Database.
  static const String _baseUrl =
      'https://study-project-36199-default-rtdb.europe-west1.firebasedatabase.app/';
  static String get baseUrl => _baseUrl;

  // API Endpoints
  // URL for fetching the shopping list from the Firebase Realtime Database.
  static Uri get shoppingListUrl => Uri.https(_baseUrl, 'shopping-list.json');

  // App Details
  // Name of the app displayed in the app bar or as the app title.
  static const String appName = 'Shopping List';

  // Timeouts for network requests (using Dio).
  static const Duration connectTimeout = Duration(milliseconds: 5000);
  static const Duration receiveTimeout = Duration(milliseconds: 3000);

  // Primary and secondary colors used across the app.
  // These represent iOS-specific colors for a consistent, native look.
  static const Color kPrimaryColor = Color(0xFF007AFF); // iOS Blue
  static const Color kSecondaryColor = Color(0xFF34C759); // iOS Green

  // Font sizes used in various text elements.
  static const double appBarTitleFontSize = 20.0;
  static const double elevatedButtonFontSize = 16.0;
  static const double titleLargeFontSize = 20.0;
  static const double bodyMediumFontSize = 16.0;
  static const double bodyLargeFontSize = 18.0;
  static const double quantityFontSize = 16.0;
  static const double categoryFontSize = 14.0;
  static const double inputFontSize = 16.0;
  static const double dropdownFontSize = 16.0;

  // Spacing, padding, and margins for UI elements.
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

  // Padding for the 'New Item' screen.
  static const EdgeInsets newItemPadding = EdgeInsets.all(12.0);

  // Border radius for various elements (buttons, cards, inputs).
  static const double elevatedButtonBorderRadius = 12.0;
  static const double cardBorderRadius = 15.0;
  static const double inputBorderRadius = 12.0;
  static const double dropdownBorderRadius = 12.0;

  // Elevation settings for cards and other components.
  static const double cardElevation = 2.0;

  // Sizes for input fields and other components.
  static const double quantityFieldWidth = 100.0;
  static const double elevatedButtonWidth = 200.0;
  static const double categoryCircleSize = 14.0;
  static const double dropdownItemSpacing = 8.0;

  // Progress indicator settings.
  static const double progressIndicatorStrokeWidth = 2.0;

  // Button-related text and padding.
  static const String saveButtonText = 'Save';

  // Padding for the floating action button.
  static const EdgeInsets floatingActionButtonPadding =
      EdgeInsets.only(bottom: 125, right: 19);

  // Colors for dismissible background in lists (e.g., when swiping to delete).
  static const Color dismissibleBackgroundColor = CupertinoColors.systemRed;
  static const Color inputFillColor = Color(0xFFF5F5F5);
  static const Color dropdownFillColor = Color(0xFFF5F5F5);

  // Error messages for form validation and item actions.
  static const String removeItemErrorMessage = 'Failed to delete the item.';
  static const String nameFieldErrorMessage =
      'Must be between 1 and 50 characters.';
  static const String quantityFieldErrorMessage =
      'Must be a valid positive number.';
  static const String nameInputErrorMessage =
      'Must be between 1 and 50 characters.';
  static const String quantityInputErrorMessage =
      'Must be a valid positive number.';

  // Labels for input fields (e.g., item name, quantity).
  static const String nameFieldLabelText = 'Item to buy:';
  static const String quantityFieldLabelText = 'Quantity';
  static const String nameInputLabel = 'Item to buy:';
  static const String quantityInputLabel = 'Quantity';

  // Input field settings for the name field (max/min length).
  static const int nameInputMaxLength = 50;
  static const int nameInputMinLength = 1;
  static const int nameFieldMaxLength = 50;
  static const int nameFieldMinLength = 1;

  // Titles and messages displayed in various screens and widgets.
  static const String purchaseListTitle = 'Shopping List';
  static const String emptyListMessage = 'Add your first item! 👆🏼';
  static const String addItemTitle = 'Add to Shopping List';

  // Category names for shopping items.
  static const String vegetablesTitle = 'Vegetables';
  static const String fruitTitle = 'Fruit';
  static const String meatTitle = 'Meat';
  static const String dairyTitle = 'Dairy';
  static const String sweetsTitle = 'Sweets';
  static const String convenienceTitle = 'Convenience Foods';
  static const String otherTitle = 'Other';
  static const String purchaseLabel = 'Item to buy: ';

  // Colors for each category.
  static const Color vegetablesColor = Color.fromARGB(255, 2, 24, 13);
  static const Color fruitColor = Color.fromARGB(255, 123, 222, 2);
  static const Color meatColor = Color.fromARGB(255, 255, 102, 0);
  static const Color dairyColor = Color.fromARGB(255, 49, 217, 255);
  static const Color sweetsColor = Color.fromARGB(255, 252, 147, 1);
  static const Color convenienceColor = Color.fromARGB(255, 249, 255, 162);
  static const Color otherColor = Color.fromARGB(255, 79, 86, 86);
}

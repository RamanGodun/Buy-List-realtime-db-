import 'package:flutter/material.dart';
import 'constants.dart';

/// Defines the color scheme for the app
/// This color scheme is applied throughout the app to maintain a consistent design language.
final kColorScheme = ColorScheme.fromSwatch().copyWith(
  primary: Constants.kPrimaryColor,
  secondary: Constants.kSecondaryColor,
  surface: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
);

/// The overall theme of the app, which is based on the light theme with customizations
/// for colors, text styles, button styles, and other UI elements.
final kTheme = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.surface,

  // Customizes the appearance of the AppBar, including the background, title, and icon styles.
  appBarTheme: AppBarTheme(
    backgroundColor: kColorScheme.surface,
    elevation: 0, //  for a flat design
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Constants.appBarTitleFontSize,
      color: kColorScheme.onSurface,
    ),
    iconTheme: IconThemeData(
      color: kColorScheme.primary,
    ),
  ),

  // Customizes the style for ElevatedButtons throughout the app.
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.elevatedButtonVerticalPadding,
        horizontal: Constants.elevatedButtonHorizontalPadding,
      ), // Padding for ElevatedButtons
      backgroundColor: Constants.kPrimaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: Constants.elevatedButtonFontSize,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(Constants.elevatedButtonBorderRadius),
      ),
    ),
  ),

  // Customizes the style for Card widgets, used to display content in a framed box.
  cardTheme: CardTheme(
    elevation: Constants.cardElevation,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
    ),
  ),

  // Defines the text styles used throughout the app for different text sizes and weights.
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Constants.titleLargeFontSize,
      color: kColorScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: Constants.bodyMediumFontSize,
      color: Colors
          .grey.shade600, // Slightly lighter text for medium-sized body text
    ),
    bodyLarge: TextStyle(
      fontSize: Constants.bodyLargeFontSize, // Font size for larger body text
      color: kColorScheme.onSurface,
    ),
  ),
);

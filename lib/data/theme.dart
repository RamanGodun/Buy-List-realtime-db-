import 'package:flutter/material.dart';
import 'constants.dart';

final kColorScheme = ColorScheme.fromSwatch().copyWith(
  primary: Constants.kPrimaryColor,
  secondary: Constants.kSecondaryColor,
  surface: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
);

final kTheme = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: kColorScheme.surface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Constants.appBarTitleFontSize,
      color: kColorScheme.onSurface,
    ),
    iconTheme: IconThemeData(color: kColorScheme.primary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.elevatedButtonVerticalPadding,
          horizontal: Constants.elevatedButtonHorizontalPadding),
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
  cardTheme: CardTheme(
    elevation: Constants.cardElevation,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Constants.titleLargeFontSize,
      color: kColorScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: Constants.bodyMediumFontSize,
      color: Colors.grey.shade600,
    ),
    bodyLarge: TextStyle(
      fontSize: Constants.bodyLargeFontSize,
      color: kColorScheme.onSurface,
    ),
  ),
);

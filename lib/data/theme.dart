import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color.fromARGB(255, 245, 95, 250);
const Color kSecondaryColor = Color.fromARGB(212, 53, 212, 165);

final kColorScheme = ColorScheme.fromSwatch().copyWith(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  surface: const Color.fromARGB(255, 255, 255, 255),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
);

final kTheme = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.surface,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: kColorScheme.secondary.withOpacity(0.15),
    elevation: 1,
  ),
  tabBarTheme: const TabBarTheme().copyWith(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      maximumSize: const Size(double.infinity, double.infinity),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      backgroundColor: kColorScheme.primary,
      foregroundColor: kColorScheme.onPrimary,
      textStyle: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  cardTheme: const CardTheme().copyWith(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    color: const Color.fromARGB(255, 227, 255, 247),
    // kColorScheme.onSecondary.withOpacity(0.15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textTheme: kTextThemeData,
  //
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kColorScheme.surface,
    contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 0.2,
        color: Colors.grey,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 0.2,
        color: Colors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 0.2,
        color: Colors.grey,
      ),
    ),
  ),
);

CupertinoThemeData getCupertinoTheme() {
  return CupertinoThemeData(
    primaryColor: CupertinoColors.darkBackgroundGray,
    barBackgroundColor: kColorScheme.secondary,
    scaffoldBackgroundColor: kColorScheme.surface,
    textTheme: CupertinoTextThemeData(
      primaryColor: kColorScheme.onPrimary,
      navActionTextStyle: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      dateTimePickerTextStyle: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

final kTextThemeData = GoogleFonts.montserratTextTheme().copyWith(
  titleLarge: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: kColorScheme.onSurface,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: kColorScheme.onSurface,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: kColorScheme.onSurface,
  ),
);

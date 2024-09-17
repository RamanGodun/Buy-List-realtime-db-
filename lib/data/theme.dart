import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color.fromARGB(255, 245, 95,
    250); // Можна змінити на пастельний відтінок для більш мінімалістичного вигляду
const Color kSecondaryColor =
    Color.fromARGB(212, 53, 212, 165); // Залишаємо або робимо м'якішим

final kColorScheme = ColorScheme.fromSwatch().copyWith(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  surface: const Color.fromARGB(255, 255, 255, 255), // Білий для фону
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
);

final kTheme = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: kColorScheme.surface,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor:
        kColorScheme.secondary.withOpacity(0.12), // Більш прозорий AppBar
    elevation: 0.5, // Менша тінь
    titleTextStyle: GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: kColorScheme.onSurface,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      maximumSize: const Size(double.infinity, double.infinity),
      padding: const EdgeInsets.symmetric(
          vertical: 12, horizontal: 35), // Трохи більше padding для легкості
      backgroundColor: kColorScheme.primary
          .withOpacity(0.9), // Трохи прозорий колір для легшого вигляду
      foregroundColor: kColorScheme.onPrimary,
      textStyle: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Більш закруглені кути
      ),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 3, // Зменшена тінь для карток
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    color: const Color.fromARGB(
        255, 240, 250, 255), // Світлий пастельний колір карток
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Закруглені кути
    ),
  ),
  textTheme: kTextThemeData,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kColorScheme.surface,
    contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15), // Трохи більше padding для кращого вигляду
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // Закруглені кути
      borderSide: const BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.blueAccent, // Акцент на синій при фокусі
      ),
    ),
  ),
);

CupertinoThemeData getCupertinoTheme() {
  return CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: kColorScheme.secondary.withOpacity(0.2),
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
    fontWeight: FontWeight.w600,
    fontSize: 22, // Трохи більший розмір для заголовків
    color: kColorScheme.onSurface,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: kColorScheme.onSurface
        .withOpacity(0.7), // Легший колір для звичайного тексту
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: kColorScheme.onSurface,
  ),
);

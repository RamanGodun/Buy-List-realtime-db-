import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'data/constants.dart';
import 'data/theme.dart';
import 'UI/pages/purchases_list_page.dart';
import 'domain/services/api_service.dart';

/*
Technologies and skills, used in this app:
1. **Dio** - for HTTP requests.
2. **Retrofit** - code generation for REST API handling.
3. **Code Generation** - for Retrofit and other repetitive tasks.
4. **Firebase Realtime Database** - for real-time data storage and synchronization.
5. **GetIt** - for dependency injection, managing service instantiation.
6. **ValueNotifier** - for lightweight state management and efficient UI rebuilds.
7. **App Designing** - with help of Cupertino Widgets, Material Design Widgets and Google Fonts
8. **Others**  - Flutter, Dart, OOP, SOLID, GIT, RESTs API, AI operator's skill
*/

/// The `main` function serves as the app's entry point.
/// It initializes the service locator for dependency injection and launches the Flutter app.
void main() {
  setupLocator(); // Set up service locator for injecting dependencies globally across the app
  runApp(const MyApp()); // Start the app by loading the `MyApp` widget tree
}

/// Root widget for the app. Applies global theme and initial route.
///
/// This widget applies the custom theme defined in `theme.dart`, uses
/// the name provided in the `Constants.appName`, and sets `PurchaseList` as the home screen.
/// It ensures a uniform look and feel across the app and manages app-wide settings.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: kTheme, // Global theme applied
      home:
          const PurchaseList(), // The initial screen displayed after the app starts
    );
  }
}

/// Registers essential services and dependencies using `GetIt`.
///
/// - **Dio** is set up for making HTTP requests with pre-configured timeouts.
/// - **ApiService**: a singleton that handles communication with the REST API, created using the `Retrofit` code generator.
void setupLocator() {
  final dio = Dio();
  dio.options = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: Constants.connectTimeout,
    receiveTimeout: Constants.receiveTimeout,
  );

  // Register ApiService using GetIt, ensuring only one instance (singleton) is created and used across the app
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService(dio));
}

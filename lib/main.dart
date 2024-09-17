import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'data/constants.dart';
import 'data/theme.dart';
import 'UI/pages/purchases_list_page.dart';
import 'domain/services/api_service.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Закупи',
      theme: kTheme,
      home: const PurchaseList(),
    );
  }
}

void setupLocator() {
  final dio = Dio();
  // Вказуємо базовий URL напряму в коді
  dio.options = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  );
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService(dio));
}

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
      title: Constants.appName,
      theme: kTheme,
      home: const PurchaseList(),
    );
  }
}

void setupLocator() {
  final dio = Dio();
  dio.options = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: Constants.connectTimeout,
    receiveTimeout: Constants.receiveTimeout,
  );
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService(dio));
}

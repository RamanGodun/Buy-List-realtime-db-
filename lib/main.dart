import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'data/theme.dart';
import 'UI/components/purchases_list.dart';
import 'domain/services/api_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService());
}

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

import 'package:flutter/material.dart';
import 'data/theme.dart';
import 'UI/widgets/purchases_list.dart';

void main() {
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

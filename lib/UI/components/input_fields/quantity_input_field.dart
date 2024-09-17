import 'package:flutter/material.dart';

class QuantityInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextTheme textTheme;

  const QuantityInputField({
    super.key,
    required this.controller,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Кількість',
        labelStyle: textTheme.bodyMedium,
      ),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 16),
      validator: (value) {
        if (int.tryParse(value!) == null || int.parse(value) <= 0) {
          return 'Має бути дійсним позитивним числом.';
        }
        return null;
      },
    );
  }
}

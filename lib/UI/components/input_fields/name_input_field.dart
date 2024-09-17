import 'package:flutter/material.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextTheme textTheme;

  const NameInputField({
    super.key,
    required this.controller,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: 50,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Потрібно купити: ',
        labelStyle: textTheme.bodyMedium,
      ),
      style: textTheme.bodyMedium,
      validator: (value) {
        if (value!.trim().length <= 1 || value.trim().length > 50) {
          return 'Має бути від 1 до 50 символів.';
        }
        return null;
      },
    );
  }
}

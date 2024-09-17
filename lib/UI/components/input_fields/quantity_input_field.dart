import 'package:flutter/material.dart';
import '../../../data/constants.dart'; // Імпорт констант

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
        labelText: Constants.quantityInputLabel,
        labelStyle: textTheme.bodyMedium,
        filled: true,
        fillColor: Constants.inputFillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Constants.inputVerticalPadding,
          horizontal: Constants.inputHorizontalPadding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: Constants.inputFontSize),
      validator: (value) {
        if (int.tryParse(value!) == null || int.parse(value) <= 0) {
          return Constants.quantityInputErrorMessage;
        }
        return null;
      },
    );
  }
}

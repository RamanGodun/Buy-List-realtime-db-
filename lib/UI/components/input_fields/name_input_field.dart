import 'package:flutter/material.dart';
import '../../../data/constants.dart';

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
      maxLength: Constants.nameInputMaxLength,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: Constants.nameInputLabel,
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
      style: textTheme.bodyMedium,
      validator: (value) {
        if (value!.trim().length <= Constants.nameInputMinLength ||
            value.trim().length > Constants.nameInputMaxLength) {
          return Constants.nameInputErrorMessage;
        }
        return null;
      },
    );
  }
}

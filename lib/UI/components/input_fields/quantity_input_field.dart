import 'package:flutter/material.dart';
import '../../../data/constants.dart';

/// A custom text input field for entering the quantity of an item.
/// It validates that the input is a positive number and applies predefined styles.
class QuantityInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextTheme textTheme;

  /// Constructor for QuantityInputField that requires a [TextEditingController] and [TextTheme].
  const QuantityInputField({
    super.key,
    required this.controller,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Binds the controller to the text field.

      // Input decoration with label, padding, background color, and border styling.
      decoration: InputDecoration(
        labelText: Constants.quantityInputLabel,
        labelStyle: textTheme.bodyMedium,
        filled: true,
        fillColor: Constants.inputFillColor,

        // Padding around the text inside the input field.
        contentPadding: const EdgeInsets.symmetric(
          vertical: Constants.inputVerticalPadding,
          horizontal: Constants.inputHorizontalPadding,
        ),

        // Custom border for the input field with rounded corners and no visible border line.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          borderSide: BorderSide.none, // No visible border for a clean look.
        ),
      ),

      keyboardType:
          TextInputType.number, // Sets the input type to numbers only.

      // Applies a constant text style for the input field.
      style: const TextStyle(fontSize: Constants.inputFontSize),

      // Validator to ensure the input is a valid positive number.
      validator: (value) {
        if (int.tryParse(value!) == null || int.parse(value) <= 0) {
          return Constants
              .quantityInputErrorMessage; // Returns an error if the value is not valid.
        }
        return null; // If validation passes, no error message is returned.
      },
    );
  }
}

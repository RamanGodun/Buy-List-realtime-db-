import 'package:flutter/material.dart';
import '../../../data/constants.dart';

/// A custom text input field used to capture the name of an item.
/// This field has a predefined max length and uses form validation to ensure input is within the specified character limits.
class NameInputField extends StatelessWidget {
  final TextEditingController controller; //  for managing the text input value.
  final TextTheme textTheme;

  /// Constructor for NameInputField that accepts a [TextEditingController] and [TextTheme].
  const NameInputField({
    super.key,
    required this.controller,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Binds the controller to the text field.
      maxLength: Constants.nameInputMaxLength,
      keyboardType: TextInputType.text,

      // Decoration for the text field including label, padding, background color, and border styling.
      decoration: InputDecoration(
        labelText: Constants.nameInputLabel,
        labelStyle: textTheme.bodyMedium,
        filled: true,
        fillColor: Constants.inputFillColor,

        // Sets padding around the text inside the input field.
        contentPadding: const EdgeInsets.symmetric(
          vertical: Constants.inputVerticalPadding,
          horizontal: Constants.inputHorizontalPadding,
        ),

        // Custom border for the input field with rounded corners and no visible border line.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.inputBorderRadius),
          borderSide: BorderSide.none, // No visible border for a cleaner look.
        ),
      ),

      style: textTheme
          .bodyMedium, // Applies the bodyMedium text style to the input text.

      // Validator to ensure input is within the required length (min and max limits).
      validator: (value) {
        if (value!.trim().length <= Constants.nameInputMinLength ||
            value.trim().length > Constants.nameInputMaxLength) {
          return Constants
              .nameInputErrorMessage; // Returns an error message if validation fails.
        }
        return null; // Returns null if validation passes.
      },
    );
  }
}

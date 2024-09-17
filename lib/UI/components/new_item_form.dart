import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../../domain/models/category_model.dart';

/// A form widget used to add new items to the shopping list.
/// It contains input fields for the item's name, quantity, and category,
/// along with validation logic and a save button.
class NewItemForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final CategoryModel? selectedCategory; //selected category for new item.
  final Function(CategoryModel?)
      onCategoryChanged; // Callback for when the category is changed.
  final GlobalKey<FormState> formKey; //to manage validation and state.
  final ValueNotifier<bool>
      isSending; //  to track the loading state of the save operation.
  final VoidCallback
      onSave; // Callback function triggered when the save button is pressed.

  const NewItemForm({
    required this.nameController,
    required this.quantityController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.formKey,
    required this.isSending,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key:
          formKey, // Associates the form with the provided formKey for validation.
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Text input for entering the name of the item to buy.
            TextFormField(
              controller: nameController,
              maxLength: 50,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: Constants.purchaseLabel,
                labelStyle: textTheme.bodyMedium,
              ),
              style: textTheme.bodyMedium,

              // Validator to ensure the input meets the length requirements.
              validator: (value) {
                if (value!.trim().length <= 1 || value.trim().length > 50) {
                  return Constants.nameInputErrorMessage; // for invalid input.
                }
                return null; // Valid input.
              },
            ),
            const SizedBox(height: 8),

            // Row containing the quantity input and category dropdown.
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Input field for entering the quantity.
                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: Constants.quantityInputLabel,
                      labelStyle: textTheme.bodyMedium,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 16), // Style for the input text.

                    // Validator to ensure the input is a valid positive number.
                    validator: (value) {
                      if (int.tryParse(value!) == null ||
                          int.parse(value) <= 0) {
                        return Constants
                            .quantityInputErrorMessage; // Error message for invalid input.
                      }
                      return null; // Valid input.
                    },
                  ),
                ),
                const SizedBox(width: 8),

                // Dropdown field for selecting the category of the item.
                Expanded(
                  child: DropdownButtonFormField<CategoryModel>(
                    value: selectedCategory, // Currently selected category.

                    // Maps each category from categoriesData to a dropdown menu item.
                    items: categoriesData.entries
                        .map((category) => DropdownMenuItem<CategoryModel>(
                              value: category
                                  .value, // Value associated with the dropdown item.
                              child: Row(
                                children: [
                                  // Color indicator for the category.
                                  Container(
                                    width: 13,
                                    height: 13,
                                    decoration: BoxDecoration(
                                      color: category.value
                                          .color, // The color of the category.
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  // Text displaying the category title.
                                  Text(
                                    category.value.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged:
                        onCategoryChanged, // Triggered when the category is changed.
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row containing the save button, aligned to the right.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29.0),
                  child: ValueListenableBuilder<bool>(
                    valueListenable:
                        isSending, // Monitors the sending state (loading).
                    builder: (context, isSending, child) {
                      return ElevatedButton(
                        onPressed: isSending
                            ? null
                            : onSave, // Disable button when sending.
                        child: isSending
                            ? const CircularProgressIndicator(
                                strokeWidth: 2) // Show loading spinner.
                            : const Text(Constants
                                .saveButtonText), // Button text when not loading.
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

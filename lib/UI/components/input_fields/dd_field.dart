import 'package:flutter/material.dart';
import '../../../data/constants.dart';
import '../../../domain/models/category_model.dart';

/// A custom dropdown field widget used for selecting a category from a predefined list.
/// The dropdown contains a list of categories, each with a color circle and a text label.
class CategoryDropdownField extends StatelessWidget {
  final CategoryModel? selectedCategory;
  final ValueChanged<CategoryModel?>
      onChanged; //triggered when the selected category changes.
  final TextTheme textTheme;

  const CategoryDropdownField({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      value: selectedCategory, // Binds the selected value to the dropdown.

      // Input decoration for styling the dropdown.
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: Constants.dropdownVerticalPadding,
          horizontal: Constants.dropdownHorizontalPadding,
        ),
        filled: true, // Ensures the dropdown background is filled.
        fillColor: Constants.dropdownFillColor,

        // Custom border with rounded corners.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.dropdownBorderRadius),
          borderSide: BorderSide.none, // No visible border.
        ),
      ),

      // Maps categories to DropdownMenuItem widgets for display in the dropdown.
      items: categoriesData.entries.map((category) {
        return DropdownMenuItem(
          value: category.value, // Sets the value of the dropdown item.

          // Each dropdown item consists of a colored circle and the category name.
          child: Row(
            children: [
              // Circle representing the color of the category.
              Container(
                width:
                    Constants.categoryCircleSize, // Size of the color circle.
                height: Constants.categoryCircleSize,
                decoration: BoxDecoration(
                  color: category
                      .value.color, // The color associated with the category.
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: Constants.dropdownItemSpacing),

              // The category title text.
              Text(
                category.value.title,
                style: TextStyle(
                  fontSize: Constants.dropdownFontSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),

      onChanged:
          onChanged, // Calls the provided callback when a new category is selected.
    );
  }
}

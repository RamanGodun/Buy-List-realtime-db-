import 'package:flutter/material.dart';
import '../../../data/constants.dart';
import '../../../domain/models/category_model.dart';

class CategoryDropdownField extends StatelessWidget {
  final CategoryModel? selectedCategory;
  final ValueChanged<CategoryModel?> onChanged;
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
      value: selectedCategory,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: Constants.dropdownVerticalPadding,
          horizontal: Constants.dropdownHorizontalPadding,
        ),
        filled: true,
        fillColor: Constants.dropdownFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.dropdownBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      items: categoriesData.entries.map((category) {
        return DropdownMenuItem(
          value: category.value,
          child: Row(
            children: [
              Container(
                width: Constants.categoryCircleSize,
                height: Constants.categoryCircleSize,
                decoration: BoxDecoration(
                  color: category.value.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: Constants.dropdownItemSpacing),
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
      onChanged: onChanged,
    );
  }
}

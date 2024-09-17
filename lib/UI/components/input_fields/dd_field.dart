import 'package:flutter/material.dart';
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
      items: categoriesData.entries.map((category) {
        return DropdownMenuItem(
          value: category.value,
          child: Row(
            children: [
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: category.value.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                category.value.title,
                style: TextStyle(
                  fontSize: 14,
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

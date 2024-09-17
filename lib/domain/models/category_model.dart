import 'package:flutter/material.dart';
import '../../../data/constants.dart';

enum CategoryEnums {
  vegetables,
  fruit,
  meat,
  dairy,
  sweets,
  convenience,
  other
}

class CategoryModel {
  const CategoryModel(this.title, this.color);

  final String title;
  final Color color;
}

final Map<CategoryEnums, CategoryModel> categoriesData = {
  CategoryEnums.vegetables: const CategoryModel(
    Constants.vegetablesTitle,
    Constants.vegetablesColor,
  ),
  CategoryEnums.fruit: const CategoryModel(
    Constants.fruitTitle,
    Constants.fruitColor,
  ),
  CategoryEnums.meat: const CategoryModel(
    Constants.meatTitle,
    Constants.meatColor,
  ),
  CategoryEnums.dairy: const CategoryModel(
    Constants.dairyTitle,
    Constants.dairyColor,
  ),
  CategoryEnums.sweets: const CategoryModel(
    Constants.sweetsTitle,
    Constants.sweetsColor,
  ),
  CategoryEnums.convenience: const CategoryModel(
    Constants.convenienceTitle,
    Constants.convenienceColor,
  ),
  CategoryEnums.other: const CategoryModel(
    Constants.otherTitle,
    Constants.otherColor,
  ),
};

// Функція для отримання назви категорії (може використовуватися за потребою)
// String categoryDisplayName(CategoryEnums category) {
//   return categoriesData[category]?.title ?? 'Невідома категорія';
// }

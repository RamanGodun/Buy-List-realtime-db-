import 'package:flutter/material.dart';

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

// Створюємо Map для назв категорій і кольорів
final Map<CategoryEnums, CategoryModel> categoriesData = {
  CategoryEnums.vegetables: const CategoryModel(
    'Овочі',
    Color.fromARGB(173, 2, 38, 20),
  ),
  CategoryEnums.fruit: const CategoryModel(
    'Фрукти',
    Color.fromARGB(255, 73, 81, 63),
  ),
  CategoryEnums.meat: const CategoryModel(
    'М\'ясо',
    Color.fromARGB(255, 255, 102, 0),
  ),
  CategoryEnums.dairy: const CategoryModel(
    'Молочне',
    Color.fromARGB(255, 102, 219, 246),
  ),
  CategoryEnums.sweets: const CategoryModel(
    'Солодощі',
    Color.fromARGB(255, 251, 210, 154),
  ),
  CategoryEnums.convenience: const CategoryModel(
    'Зручні продукти',
    Color.fromARGB(255, 241, 246, 177),
  ),
  CategoryEnums.other: const CategoryModel(
    'Інше',
    Color.fromARGB(255, 154, 159, 159),
  ),
};

// Функція для отримання назви категорії (може використовуватися за потребою)
String categoryDisplayName(CategoryEnums category) {
  return categoriesData[category]?.title ?? 'Невідома категорія';
}

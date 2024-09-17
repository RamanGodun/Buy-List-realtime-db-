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

String categoryDisplayName(CategoryEnums category) {
  switch (category) {
    case CategoryEnums.vegetables:
      return 'Овочі';
    case CategoryEnums.fruit:
      return 'Фрукти';
    case CategoryEnums.meat:
      return 'М\'ясо';
    case CategoryEnums.dairy:
      return 'Молочне';
    case CategoryEnums.sweets:
      return 'Солодощі';
    case CategoryEnums.convenience:
      return 'Зручні продукти';
    case CategoryEnums.other:
      return 'Інше';
  }
}

final categoriesData = {
  CategoryEnums.vegetables: CategoryModel(
    categoryDisplayName(CategoryEnums.vegetables),
    const Color.fromARGB(173, 2, 38, 20),
  ),
  CategoryEnums.fruit: CategoryModel(
    categoryDisplayName(CategoryEnums.fruit),
    const Color.fromARGB(255, 73, 81, 63),
  ),
  CategoryEnums.meat: CategoryModel(
    categoryDisplayName(CategoryEnums.meat),
    const Color.fromARGB(255, 255, 102, 0),
  ),
  CategoryEnums.dairy: CategoryModel(
    categoryDisplayName(CategoryEnums.dairy),
    const Color.fromARGB(255, 102, 219, 246),
  ),
  CategoryEnums.sweets: CategoryModel(
    categoryDisplayName(CategoryEnums.sweets),
    const Color.fromARGB(255, 251, 210, 154),
  ),
  CategoryEnums.convenience: CategoryModel(
    categoryDisplayName(CategoryEnums.convenience),
    const Color.fromARGB(255, 241, 246, 177),
  ),
  CategoryEnums.other: CategoryModel(
    categoryDisplayName(CategoryEnums.other),
    const Color.fromARGB(255, 154, 159, 159),
  ),
};

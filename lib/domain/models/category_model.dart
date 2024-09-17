import 'package:flutter/material.dart';
import '../../../data/constants.dart';
import 'enums.dart';

/// Represents a category for a shopping item, containing a title and color.
class CategoryModel {
  /// The name of the category (e.g., "Vegetables", "Fruits").
  final String title;

  /// The color associated with the category (used in the UI for differentiation).
  final Color color;

  const CategoryModel(this.title, this.color);
}

/// A map that associates each `CategoryEnums` value with its corresponding `CategoryModel`.
/// This allows easy lookup of category details based on the enum.
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

/// Example function for fetching the display name of a category based on its enum value.
/// Uncomment this if needed for displaying category names.
/// 
/// String categoryDisplayName(CategoryEnums category) {
///   return categoriesData[category]?.title ?? 'Unknown category';
/// }

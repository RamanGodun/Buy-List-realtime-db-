import 'category_model.dart';
import 'enums.dart';

/*
  The model representing an item in the shopping list.
This class is used to define the structure of each shopping list item,
including its ID, name, quantity, and category.
 */

class PurchaseItemModel {
  /// The unique identifier of the item. This may be `null` if the item is new and not yet stored.
  final String? id;
  final String name;
  final int quantity;

  /// The name of the category the item belongs to (e.g., "Fruits", "Vegetables").
  final String categoryName;

  PurchaseItemModel({
    /// The `id` is optional, as it may be generated later (e.g., by Firebase).
    required this.id,
    required this.name,
    required this.quantity,
    required this.categoryName,
  });

/*
    Returns the `CategoryModel` based on the `categoryName`.
  If no match is found, it defaults to the "Other" category.
  This method ensures that every item has an associated category.
 */

  CategoryModel get category {
    return categoriesData.entries
        .firstWhere(
          (entry) =>
              entry.value.title == categoryName, // Matches by category name
          orElse: () => MapEntry(
              CategoryEnums.other, categoriesData[CategoryEnums.other]!),
        )
        .value;
  }

  /// Creates a `PurchaseItemModel` instance from JSON.
  /// This is typically used when fetching data from Firebase or another API.
  factory PurchaseItemModel.fromJson(Map<String, dynamic> json, String id) {
    return PurchaseItemModel(
      id: id, // Firebase generates the ID, passed in during deserialization.
      name: json['name'] as String, // Parses the name from JSON.
      quantity: json['quantity'] as int, // Parses the quantity from JSON.
      categoryName:
          json['categoryName'] as String, // Parses the category name from JSON.
    );
  }

  /// Converts the `PurchaseItemModel` instance to JSON format.
  /// This is used when sending data to Firebase or another API.
  Map<String, dynamic> toJson() {
    return {
      'id': DateTime.now()
          .microsecondsSinceEpoch
          .toString(), // Generates a unique ID using the current timestamp.
      'name': name, // Includes the item name in the JSON output.
      'quantity': quantity, // Includes the item quantity in the JSON output.
      'categoryName':
          categoryName, // Includes the category name in the JSON output.
    };
  }
}

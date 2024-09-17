import 'category_model.dart';

class PurchaseItemModel {
  final String? id;
  final String name;
  final int quantity;
  final String categoryName;

  PurchaseItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.categoryName,
  });

  // Генератор категорії на основі імені категорії
  CategoryModel get category {
    return categoriesData.entries
        .firstWhere(
          (entry) => entry.value.title == categoryName,
          orElse: () => MapEntry(
              CategoryEnums.other, categoriesData[CategoryEnums.other]!),
        )
        .value;
  }

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json, String id) {
    return PurchaseItemModel(
      id: id, // Отримуємо ID з Firebase
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      categoryName: json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
      'name': name,
      'quantity': quantity,
      'categoryName': categoryName,
    };
  }
}

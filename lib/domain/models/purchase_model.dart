import 'category_model.dart';

class PurchaseItemModel {
  final String? id;
  final String name;
  final int quantity;
  final CategoryModel category;

  PurchaseItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category.title,
    };
  }
}

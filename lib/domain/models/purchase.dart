import 'category.dart';

class PurchaseItem {
  final String id;
  final String name;
  final int quantity;
  final CategoryModel category;

  PurchaseItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/models/purchase_model.dart';
import '../../domain/services/api_service.dart';

class ListItemWidget extends StatelessWidget {
  final PurchaseItemModel item;
  final TextTheme textTheme;
  final ApiService apiService;
  final ValueNotifier<List<PurchaseItemModel>> itemsNotifier;
  final ValueNotifier<bool> isLoading;
  final Function(String message) showErrorMessage;

  const ListItemWidget({
    super.key,
    required this.item,
    required this.textTheme,
    required this.apiService,
    required this.itemsNotifier,
    required this.isLoading,
    required this.showErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      onDismissed: (direction) {
        apiService.removeItem(item, itemsNotifier, isLoading, showErrorMessage);
      },
      background: Container(
        color: CupertinoColors.systemRed.withOpacity(0.2),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(
          item.name,
          style: textTheme.bodyLarge?.copyWith(color: item.category.color),
        ),
        leading: Checkbox(
          value: false,
          onChanged: (bool? value) {
            if (value == true) {
              apiService.removeItem(
                  item, itemsNotifier, isLoading, showErrorMessage);
            }
          },
        ),
        trailing: Text(
          item.quantity.toString(),
          style: textTheme.bodyMedium?.copyWith(color: item.category.color),
        ),
      ),
    );
  }
}

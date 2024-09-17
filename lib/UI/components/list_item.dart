import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/models/purchase_model.dart';
import '../../domain/services/api_service.dart';

class ListItemWidget extends StatefulWidget {
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
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item.id),
      onDismissed: (direction) async {
        widget.isLoading.value = true;
        try {
          await widget.apiService.removeItem(widget.item.id!);
          // Оновлюємо список після видалення елемента
          widget.itemsNotifier.value = widget.itemsNotifier.value
              .where((item) => item.id != widget.item.id)
              .toList();
        } catch (error) {
          widget.showErrorMessage('Не вдалося видалити елемент.');
        } finally {
          widget.isLoading.value = false;
        }
      },
      background: Container(
        color: CupertinoColors.systemRed.withOpacity(0.2),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(
          widget.item.name,
          style: widget.textTheme.bodyLarge
              ?.copyWith(color: widget.item.category.color),
        ),
        leading: Checkbox(
          value: false,
          onChanged: (bool? value) async {
            if (value == true) {
              widget.isLoading.value = true;
              try {
                await widget.apiService.removeItem(widget.item.id!);
                // Оновлюємо список після видалення елемента
                widget.itemsNotifier.value = widget.itemsNotifier.value
                    .where((item) => item.id != widget.item.id)
                    .toList();
              } catch (error) {
                widget.showErrorMessage('Не вдалося видалити елемент.');
              } finally {
                widget.isLoading.value = false;
              }
            }
          },
        ),
        trailing: Text(
          widget.item.quantity.toString(),
          style: widget.textTheme.bodyMedium
              ?.copyWith(color: widget.item.category.color),
        ),
      ),
    );
  }
}

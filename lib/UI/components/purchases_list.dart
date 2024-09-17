import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../../domain/models/purchase_model.dart';
import '../../domain/services/api_service.dart';
import 'new_item.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  final ApiService _apiService = GetIt.I<ApiService>();
  final ValueNotifier<List<PurchaseItemModel>> _itemsNotifier =
      ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Список покупок',
          style: textTheme.titleMedium,
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<List<PurchaseItemModel>>(
            valueListenable: _itemsNotifier,
            builder: (context, items, child) {
              if (items.isEmpty) {
                return const Center(
                    child: Text('Додайте свою першу покупку "+"👆🏼'));
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    itemCount: items.length,
                    itemBuilder: (ctx, index) =>
                        _buildListItem(items[index], textTheme),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          await _navigateToAddItem();
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(PurchaseItemModel item, TextTheme textTheme) {
    return Dismissible(
      key: ValueKey(item.id),
      onDismissed: (direction) {
        _removeItem(item);
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
              _removeItem(item);
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

  Future<void> _loadItems() async {
    _isLoading.value = true;
    try {
      final items = await _apiService.fetchItemsFromDB();
      _itemsNotifier.value = items;
    } on SocketException {
      _showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      _showErrorMessage('Не вдалося завантажити дані. Спробуйте пізніше.');
    } finally {
      _isLoading.value = false;
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _addItem(PurchaseItemModel newItem) async {
    _isLoading.value = true;
    try {
      await _apiService.addItem(newItem);
      _itemsNotifier.value = [..._itemsNotifier.value, newItem];
    } on SocketException {
      _showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      _showErrorMessage('Не вдалося додати елемент.');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _removeItem(PurchaseItemModel item) async {
    _isLoading.value = true;
    try {
      await _apiService.deleteItem(item.id!);
      _itemsNotifier.value =
          _itemsNotifier.value.where((i) => i.id != item.id).toList();
    } on SocketException {
      _showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      _showErrorMessage('Не вдалося видалити елемент.');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _navigateToAddItem() async {
    final newItem = await Navigator.of(context).push<PurchaseItemModel>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );
    if (newItem != null) {
      await _addItem(newItem);
    }
  }
}

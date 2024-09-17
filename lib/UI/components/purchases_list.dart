import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../data/constants.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/purchase_model.dart';
import 'new_item.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  final ValueNotifier<List<PurchaseItemModel>> _itemsNotifier =
      ValueNotifier([]);
  final url = Constants.shoppingListUrl;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Список покупок',
          style: textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ValueListenableBuilder<List<PurchaseItemModel>>(
          valueListenable: _itemsNotifier,
          builder: (context, items, child) {
            if (items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
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
        ),
      ),
      floatingActionButton: InkWell(
        onTap: _addItem,
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
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Не вдалося отримати дані. Спробуйте пізніше.');
    }

    if (response.body == 'null') {
      _itemsNotifier.value = [];
      return;
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    _itemsNotifier.value = listData.entries.map((item) {
      final category = categoriesData.entries
          .firstWhere((categoryItem) =>
              categoryItem.value.title == item.value['category'])
          .value;

      return PurchaseItemModel(
        id: item.key,
        name: item.value['name'],
        quantity: int.tryParse(item.value['quantity'].toString()) ?? 1,
        category: category,
      );
    }).toList();
  }

  Future<void> _addItem() async {
    final newItem = await Navigator.of(context).push<PurchaseItemModel>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );

    if (newItem != null) {
      _itemsNotifier.value = [..._itemsNotifier.value, newItem];
    }
  }

  Future<void> _removeItem(PurchaseItemModel item) async {
    final deleteUrl =
        Uri.https(Constants.baseUrl, 'shopping-list/${item.id}.json');
    final response = await http.delete(deleteUrl);

    if (response.statusCode >= 400) {
      // Обробник помилок
    } else {
      _itemsNotifier.value =
          _itemsNotifier.value.where((i) => i.id != item.id).toList();
    }
  }
}

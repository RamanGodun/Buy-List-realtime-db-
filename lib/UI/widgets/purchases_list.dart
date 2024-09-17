import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:g_tracker/data/constants.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/category.dart';
import '../../domain/models/purchase.dart';
import 'new_item.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  //
  final _baseUrl = Constants.baseUrl;
  final url = Constants.shoppingListUrl;
  late Future<List<PurchaseItem>> _loadedItems;

  //
  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    //
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
        child: FutureBuilder(
          future: _loadedItems,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : snapshot.hasError
                    ? Center(
                        child: Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge,
                        ),
                      )
                    : snapshot.data!.isEmpty
                        ? Center(
                            child: Text(
                              'Додайте свою першу покупку! +👆🏼',
                              style: textTheme.bodyMedium,
                            ),
                          )
                        :
                        //
                        SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (ctx, index) => InkWell(
                                  onTap: () {
                                    // Обробник натискання
                                  },
                                  child: Dismissible(
                                    onDismissed: (direction) {
                                      _removeItem(snapshot.data![index]);
                                    },
                                    key: ValueKey(snapshot.data![index].id),
                                    background: Container(
                                      color: CupertinoColors.systemRed
                                          .withOpacity(0.2),
                                      child: const Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index].name,
                                        style: textTheme.bodyLarge?.copyWith(
                                            color: snapshot
                                                .data![index].category.color),
                                      ),
                                      leading: Checkbox(
                                        value: false,
                                        onChanged: (bool? value) {
                                          if (value == true) {
                                            _removeItem(snapshot.data![index]);
                                          }
                                        },
                                      ),
                                      trailing: Text(
                                        snapshot.data![index].quantity
                                            .toString(),
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: snapshot
                                                .data![index].category.color),
                                      ),
                                    ),
                                  ),
                                ),
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

  //METHODS next
  Future<List<PurchaseItem>> _loadItems() async {
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception(
          'Не вдалося отримати дані. Будь-ласка, спробуйте пізніше 😲');
    }
    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<PurchaseItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categoriesData.entries
          .firstWhere((categoryItem) =>
              categoryItem.value.title == item.value['category'])
          .value;

      loadedItems.add(
        PurchaseItem(
          id: item.key,
          name: item.value['name'],
          quantity: int.tryParse(item.value['quantity'].toString()) ?? 1,
          category: category,
        ),
      );
    }
    return loadedItems;
  }

  Future<void> _addItem() async {
    final newItem = await Navigator.of(context).push<PurchaseItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem != null) {
      setState(() {
        _loadedItems = _loadItems();
      });
    }
  }

  Future<void> _removeItem(PurchaseItem item) async {
    final deleteUrl = Uri.https(_baseUrl, 'shopping-list/${item.id}.json');
    final response = await http.delete(deleteUrl);

    if (response.statusCode >= 400) {
      // Обробник помилок
    } else {
      setState(() {
        _loadedItems = _loadItems();
      });
    }
  }
}

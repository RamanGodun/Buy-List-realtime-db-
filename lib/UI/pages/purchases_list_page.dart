import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/constants.dart';
import '../../domain/models/purchase_model.dart';
import '../../domain/services/api_service.dart';
import '../components/list_item.dart';
import 'new_item_page.dart';

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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          Constants.purchaseListTitle,
          style: textTheme.titleLarge,
        ),
        elevation: 0,
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CupertinoActivityIndicator(radius: 25));
          }

          return ValueListenableBuilder<List<PurchaseItemModel>>(
            valueListenable: _itemsNotifier,
            builder: (context, items, child) {
              if (items.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 508.0),
                  child: Center(child: Text(Constants.emptyListMessage)),
                );
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    itemCount: items.length,
                    itemBuilder: (ctx, index) => ListItemWidget(
                      item: items[index],
                      textTheme: textTheme,
                      apiService: _apiService,
                      itemsNotifier: _itemsNotifier,
                      isLoading: _isLoading,
                      showErrorMessage: _showErrorMessage,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: Constants.floatingActionButtonPadding,
        child: FloatingActionButton(
          onPressed: () async {
            await _navigateToAddItem();
          },
          backgroundColor: Constants.kPrimaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

/*
  Used METHODS are next:
 */
  Future<void> _loadItems() async {
    _isLoading.value = true;
    try {
      final response = await _apiService.fetchItems();
      // Перевірка тільки на порожню відповідь
      if (response.isEmpty) {
        _itemsNotifier.value = [];
      } else {
        // Обробка даних, якщо вони присутні
        final List<PurchaseItemModel> items = response.entries.map((entry) {
          return entry.value;
        }).toList();
        _itemsNotifier.value = items;
      }
    } catch (error) {
      _showErrorMessage('Помилка завантаження даних.');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _addItem(PurchaseItemModel newItem) async {
    _isLoading.value = true;
    try {
      // Додаємо новий елемент до Firebase без ID, Firebase згенерує його самостійно
      await _apiService.addItem(newItem);
      // Перезавантажуємо список покупок після додавання
      await _loadItems();
    } catch (error) {
      _showErrorMessage('Не вдалося додати елемент.');
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

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

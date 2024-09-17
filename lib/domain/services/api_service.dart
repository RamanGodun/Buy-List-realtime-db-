import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/purchase_model.dart';
import '../../data/constants.dart';
import '../models/category_model.dart';

class ApiService {
  /*
    FETCHING method
  */
  Future<void> loadItems(ValueNotifier<List<PurchaseItemModel>> itemsNotifier,
      ValueNotifier<bool> isLoading, Function(String) showErrorMessage) async {
    isLoading.value = true;
    try {
      final items = await fetchItemsFromDB();
      itemsNotifier.value = items;
    } on SocketException {
      showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      showErrorMessage('Не вдалося завантажити дані. Спробуйте пізніше.');
    } finally {
      isLoading.value = false;
    }
  }

  /*
    ADDING method
  */
  Future<void> addItem(
      PurchaseItemModel newItem,
      ValueNotifier<List<PurchaseItemModel>> itemsNotifier,
      ValueNotifier<bool> isLoading,
      Function(String) showErrorMessage) async {
    isLoading.value = true;
    try {
      await _addItemToDB(newItem);
      itemsNotifier.value = [...itemsNotifier.value, newItem];
    } on SocketException {
      showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      showErrorMessage('Не вдалося додати елемент.');
    } finally {
      isLoading.value = false;
    }
  }

  /*
    DELETING method
  */
  Future<void> removeItem(
      PurchaseItemModel item,
      ValueNotifier<List<PurchaseItemModel>> itemsNotifier,
      ValueNotifier<bool> isLoading,
      Function(String) showErrorMessage) async {
    isLoading.value = true;
    try {
      await _deleteItemFromDB(item.id!);
      itemsNotifier.value =
          itemsNotifier.value.where((i) => i.id != item.id).toList();
    } on SocketException {
      showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      showErrorMessage('Не вдалося видалити елемент.');
    } finally {
      isLoading.value = false;
    }
  }

  /*
    Private methods to handle DB requests
  */
  Future<List<PurchaseItemModel>> fetchItemsFromDB() async {
    final response = await http.get(Constants.shoppingListUrl);

    if (response.statusCode >= 400) {
      throw Exception('Не вдалося отримати дані.');
    }

    if (response.body.isEmpty || response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listOfPurchaseItems = json.decode(response.body);

    return listOfPurchaseItems.entries.map((item) {
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

  Future<void> _addItemToDB(PurchaseItemModel newItem) async {
    final response = await http.post(
      Constants.shoppingListUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newItem.toJson()),
    );

    if (response.statusCode >= 400) {
      throw Exception('Помилка при додаванні елемента');
    }
  }

  Future<void> _deleteItemFromDB(String itemId) async {
    final deleteUrl =
        Uri.https(Constants.baseUrl, 'shopping-list/$itemId.json');
    final response = await http.delete(deleteUrl);

    if (response.statusCode >= 400) {
      throw Exception('Помилка при видаленні елемента');
    }
  }
}

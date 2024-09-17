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
  Future<List<PurchaseItemModel>> fetchItemsFromDB() async {
    try {
      final response = await http.get(Constants.shoppingListUrl);

      // Перевірка на помилки відповіді сервера
      if (response.statusCode >= 400) {
        throw Exception('Не вдалося отримати дані. Спробуйте пізніше.');
      }

      // Перевірка на порожню відповідь
      if (response.body.isEmpty || response.body == 'null') {
        return [];
      }

      final Map<String, dynamic> listOfPurchaseItems =
          json.decode(response.body);

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
    } on SocketException {
      throw Exception('Немає інтернет-з’єднання. Перевірте підключення.');
    } on FormatException {
      throw Exception('Невірний формат відповіді від сервера.');
    } catch (error) {
      throw Exception('Сталася помилка: $error');
    }
  }

  /*
    ADDING method
  */
  Future<void> addItem(PurchaseItemModel newItem) async {
    try {
      final response = await http.post(
        Constants.shoppingListUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newItem.toJson()),
      );

      if (response.statusCode >= 400) {
        throw Exception('Помилка при додаванні елемента');
      }
    } on SocketException {
      throw Exception('Немає інтернет-з’єднання. Перевірте підключення.');
    } catch (error) {
      throw Exception('Сталася помилка: $error');
    }
  }

  /*
    DELETING method
  */
  Future<void> deleteItem(String itemId) async {
    try {
      final deleteUrl =
          Uri.https(Constants.baseUrl, 'shopping-list/$itemId.json');
      final response = await http.delete(deleteUrl);

      if (response.statusCode >= 400) {
        throw Exception('Помилка при видаленні елемента');
      }
    } on SocketException {
      throw Exception('Немає інтернет-з’єднання. Перевірте підключення.');
    } catch (error) {
      throw Exception('Сталася помилка: $error');
    }
  }

  /*
    LOADING state management
  */
  Future<void> loadItems(ValueNotifier<List<PurchaseItemModel>> itemsNotifier,
      ValueNotifier<bool> isLoading) async {
    isLoading.value = true;
    try {
      final items = await fetchItemsFromDB();
      itemsNotifier.value = items;
    } on SocketException {
      throw Exception('Немає з’єднання з інтернетом. Перевірте підключення.');
    } catch (error) {
      throw Exception('Не вдалося завантажити дані.');
    } finally {
      isLoading.value = false;
    }
  }

  /*
    ADDING item with state management
  */
  Future<void> addItemWithState(
      PurchaseItemModel newItem,
      ValueNotifier<List<PurchaseItemModel>> itemsNotifier,
      ValueNotifier<bool> isLoading) async {
    isLoading.value = true;
    try {
      await addItem(newItem);
      itemsNotifier.value = [...itemsNotifier.value, newItem];
    } catch (error) {
      throw Exception('Не вдалося додати елемент.');
    } finally {
      isLoading.value = false;
    }
  }

  /*
    DELETING item with state management
  */
  Future<void> removeItemWithState(
      PurchaseItemModel item,
      ValueNotifier<List<PurchaseItemModel>> itemsNotifier,
      ValueNotifier<bool> isLoading) async {
    isLoading.value = true;
    try {
      await deleteItem(item.id!);
      itemsNotifier.value =
          itemsNotifier.value.where((i) => i.id != item.id).toList();
    } catch (error) {
      throw Exception('Не вдалося видалити елемент.');
    } finally {
      isLoading.value = false;
    }
  }
}

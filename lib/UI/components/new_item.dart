import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/constants.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/purchase_model.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  CategoryModel? _selectedCategory = categoriesData[CategoryEnums.other];
  final ValueNotifier<bool> _isSending = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Додати до списку покупок',
          style: textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Потрібно купити: ',
                    labelStyle: textTheme.bodyMedium,
                  ),
                  style: textTheme.bodyMedium,
                  validator: (value) {
                    if (value!.trim().length <= 1 || value.trim().length > 50) {
                      return 'Має бути від 1 до 50 символів.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Кількість',
                          labelStyle: textTheme.bodyMedium,
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16),
                        validator: (value) {
                          if (int.tryParse(value!) == null ||
                              int.parse(value) <= 0) {
                            return 'Має бути дійсним позитивним числом.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items: categoriesData.entries
                            .map((category) => DropdownMenuItem(
                                  value: category.value,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                          color: category.value.color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        category.value.title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value as CategoryModel;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29.0),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isSending,
                        builder: (context, isSending, child) {
                          return ElevatedButton(
                            onPressed: isSending ? null : _saveItem,
                            child: isSending
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : const Text('Зберегти'),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      return;
    }
    _isSending.value = true;
    try {
      final newItem = PurchaseItemModel(
        id: null,
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        category: _selectedCategory!,
      );

      final response = await http.post(
        Constants.shoppingListUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newItem.toJson()),
      );
      if (response.statusCode >= 400) {
        throw Exception('Помилка при збереженні елемента.');
      }
      if (mounted) {
        Navigator.of(context).pop(PurchaseItemModel(
          id: json.decode(response.body)['name'],
          name: newItem.name,
          quantity: newItem.quantity,
          category: newItem.category,
        ));
      }
    } on SocketException {
      _showErrorMessage('Немає з’єднання з інтернетом. Перевірте підключення.');
    } on TimeoutException {
      _showErrorMessage('Час очікування відповіді від сервера сплив.');
    } catch (error) {
      _showErrorMessage('Не вдалося зберегти елемент. Спробуйте пізніше.');
    } finally {
      _isSending.value = false;
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
//
//
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:g_tracker/data/constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/category.dart';
import '../../domain/models/purchase.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  var _selectedCategory = categoriesData[CategoryEnums.other];
  var _isSending = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //
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
                        items: [
                          for (final category in categoriesData.entries)
                            DropdownMenuItem(
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
                                  Text(category.value.title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                            ),
                        ],
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
                      child: TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text(
                          'Скинути',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _isSending ? null : _saveItem,
                        child: _isSending
                            ? const SizedBox(
                                height: 14,
                                width: 14,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Додати',
                                style: textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      try {
        final response = await http.post(
          Constants.shoppingListUrl,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': _nameController.text,
            'quantity': _quantityController.text,
            'category': _selectedCategory!.title,
          }),
        );

        // without "await" I can do next:
        // .then((response) {
        // further logic && all data managing obtained from response
        // })

        // next par-tr to obtain ID (from DB) for this item,
        //that helps to avoid extra fetching of data, etc. extra load method
        final Map<String, dynamic> resData = json.decode(response.body);

        // next for "to be sure, that we not referring to context, which outdated or not available anymore"
        if (!context.mounted) {
          return;
        }

        // and then only "pop", mounted means "widget is still part of screen"
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(
          PurchaseItem(
            id: resData['name'],
            name: _nameController.text,
            quantity: int.parse(_quantityController.text),
            category: _selectedCategory!,
          ),
        );
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
  }
}

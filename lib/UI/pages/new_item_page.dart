import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/constants.dart'; // Імпорт констант
import '../../domain/models/category_model.dart';
import '../../domain/models/purchase_model.dart';
import '../components/input_fields/dd_field.dart';
import '../components/input_fields/name_input_field.dart';
import '../components/input_fields/quantity_input_field.dart';

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
          Constants.addItemTitle,
          style: textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: Constants.newItemPadding,
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Поле для вводу назви
                  NameInputField(
                    controller: _nameController,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: Constants.smallVerticalSpacing),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Поле для кількості
                      SizedBox(
                        width: Constants.quantityFieldWidth,
                        child: QuantityInputField(
                          controller: _quantityController,
                          textTheme: textTheme,
                        ),
                      ),
                      const SizedBox(width: Constants.smallHorizontalSpacing),
                      // Поле для вибору категорії
                      Expanded(
                        child: CategoryDropdownField(
                          selectedCategory: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          textTheme: textTheme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.mediumVerticalSpacing),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, top: 35),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isSending,
                        builder: (context, isSending, child) {
                          return SizedBox(
                            width: Constants.elevatedButtonWidth,
                            child: ElevatedButton(
                              onPressed: isSending ? null : _saveItem,
                              child: isSending
                                  ? const CupertinoActivityIndicator()
                                  : const Text(Constants.saveButtonText),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
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

    final newItem = PurchaseItemModel(
      id: null,
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      categoryName: _selectedCategory!.title,
    );

    Navigator.of(context).pop(newItem);
  }
}

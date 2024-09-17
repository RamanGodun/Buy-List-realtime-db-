import 'package:flutter/material.dart';
import '../../domain/models/category_model.dart';

class NewItemForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel?) onCategoryChanged;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> isSending;
  final VoidCallback onSave;

  const NewItemForm({
    required this.nameController,
    required this.quantityController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.formKey,
    required this.isSending,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
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
                    controller: quantityController,
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
                  child: DropdownButtonFormField<CategoryModel>(
                    value: selectedCategory,
                    items: categoriesData.entries
                        .map((category) => DropdownMenuItem<CategoryModel>(
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
                    onChanged: onCategoryChanged,
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
                    valueListenable: isSending,
                    builder: (context, isSending, child) {
                      return ElevatedButton(
                        onPressed: isSending ? null : onSave,
                        child: isSending
                            ? const CircularProgressIndicator(strokeWidth: 2)
                            : const Text('Зберегти'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

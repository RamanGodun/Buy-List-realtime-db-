import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/purchase_model.dart';
import '../components/input_fields/dd_field.dart';
import '../components/input_fields/name_input_field.dart';
import '../components/input_fields/quantity_input_field.dart';

/// NewItem is a stateful widget representing a form where the user can add a new item to the shopping list.
/// It provides input fields for the item name, quantity, and category.
class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  // A form key to manage form validation and state.
  final _formKey = GlobalKey<FormState>();
  // Controllers to manage the input text for the item name and quantity.
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  // Selected category for the new item, with a default value set to "Other".
  CategoryModel? _selectedCategory = categoriesData[CategoryEnums.other];
  // A notifier to track whether the form is being submitted (sending state).
  final ValueNotifier<bool> _isSending = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    // Accessing the text theme for consistent text styling.
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.addItemTitle,
          style: textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent, // for a clean design.
      ),
      body: Padding(
        padding: Constants.newItemPadding,
        child: Center(
          child: Form(
            key: _formKey, //  to manage form state.
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Input field for the item name
                  NameInputField(
                    controller: _nameController,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: Constants.smallVerticalSpacing),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Input field for the quantity
                      SizedBox(
                        width: Constants.quantityFieldWidth,
                        child: QuantityInputField(
                          controller: _quantityController,
                          textTheme: textTheme,
                        ),
                      ),
                      const SizedBox(width: Constants.smallHorizontalSpacing),
                      // Dropdown for selecting the category
                      Expanded(
                        child: CategoryDropdownField(
                          selectedCategory: _selectedCategory,
                          onChanged: (value) {
                            // Updates the selected category when the user makes a selection.
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
                      // Button that listens for the sending state using ValueListenableBuilder.
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isSending,
                        builder: (context, isSending, child) {
                          return SizedBox(
                            width: Constants.elevatedButtonWidth,
                            child: ElevatedButton(
                              onPressed: isSending
                                  ? null
                                  : _saveItem, // Disable the button if data is being sent.
                              child: isSending
                                  ? const CupertinoActivityIndicator() // Shows a loading spinner when sending.
                                  : const Text(Constants
                                      .saveButtonText), // Displays 'Save' when not sending.
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

  /// Method to save the new item when the user submits the form.
  /// It performs validation, constructs a PurchaseItemModel, and returns it to the previous screen.
  Future<void> _saveItem() async {
    // Validate the form and ensure a category is selected before proceeding.
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      return;
    }
    // Creating a new PurchaseItemModel from the user's input.
    final newItem = PurchaseItemModel(
      id: null, // The ID will be generated by Firebase.
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      categoryName: _selectedCategory!.title,
    );
    // Pops the current route and returns the new item to the previous screen.
    Navigator.of(context).pop(newItem);
  }
}

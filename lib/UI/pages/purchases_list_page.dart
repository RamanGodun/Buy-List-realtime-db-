import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/constants.dart';
import '../../domain/models/purchase_model.dart';
import '../../domain/services/api_service.dart';
import '../components/list_item.dart';
import 'new_item_page.dart';

/// This widget represents the main screen of the app, displaying a list of purchases.
/// It manages the fetching of data from the API, displays loading states, and navigates to the screen for adding new items.
class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  // ApiService instance injected via GetIt to manage API requests.
  final ApiService _apiService = GetIt.I<ApiService>();
  // Notifiers to manage the state of the list of items and loading state.
  final ValueNotifier<List<PurchaseItemModel>> _itemsNotifier =
      ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  // Stores the current theme for easy access throughout the widget.
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    // Load the items when the widget is first initialized.
    _loadItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the theme once the context is available.
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    // Access the text theme for consistent styling.
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          Constants.purchaseListTitle, // ('Shopping List').
          style: textTheme.titleLarge,
        ),
        elevation: 0, // to maintain a clean look.
      ),
      // Displays a loading indicator while data is being fetched.
      body: ValueListenableBuilder<bool>(
        valueListenable: _isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(radius: 25),
            );
          }

          // Displays the list of items once data is loaded.
          return ValueListenableBuilder<List<PurchaseItemModel>>(
            valueListenable: _itemsNotifier,
            builder: (context, items, child) {
              // If there are no items, display a message.
              if (items.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 508.0),
                  child: Center(child: Text(Constants.emptyListMessage)),
                );
              }

              // If items exist, display them in a ListView.
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors
                          .grey.shade300, // Light gray divider between items.
                      thickness: 1,
                    ),
                    itemCount: items.length,
                    itemBuilder: (ctx, index) => ListItemWidget(
                      item: items[index],
                      textTheme: textTheme,
                      apiService:
                          _apiService, // API service for deleting items.
                      itemsNotifier:
                          _itemsNotifier, // Notifies when items change.
                      isLoading: _isLoading, // Controls the loading state.
                      showErrorMessage:
                          _showErrorMessage, // Shows error messages.
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      // Floating action button for adding new items.
      floatingActionButton: Padding(
        padding: Constants.floatingActionButtonPadding,
        child: FloatingActionButton(
          onPressed: () async {
            await _navigateToAddItem(); // Navigates to the page for adding a new item.
          },
          backgroundColor: Constants.kPrimaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  /// Fetches the list of items from the API and updates the state.
  Future<void> _loadItems() async {
    _isLoading.value = true; // Shows the loading indicator.
    try {
      final response = await _apiService.fetchItems();
      if (response.isEmpty) {
        _itemsNotifier.value = []; // If no items are found, clear the list.
      } else {
        // Parse and add the fetched items to the list.
        final List<PurchaseItemModel> items = response.entries.map((entry) {
          return entry.value;
        }).toList();
        _itemsNotifier.value = items;
      }
    } catch (error) {
      _showErrorMessage(
          'Failed to load items.'); // Shows error if the API request fails.
    } finally {
      _isLoading.value = false; // Hides the loading indicator.
    }
  }

  /// Adds a new item to the shopping list by sending it to the API.
  Future<void> _addItem(PurchaseItemModel newItem) async {
    _isLoading.value = true; // Shows the loading indicator.
    try {
      await _apiService.addItem(newItem); // Sends the new item to the API.
      await _loadItems(); // Reload the list of items after adding a new one.
    } catch (error) {
      _showErrorMessage('Failed to add item.'); // Shows error if adding fails.
    } finally {
      _isLoading.value = false; // Hides the loading indicator.
    }
  }

  /// Navigates to the page for adding a new item.
  /// Once an item is added, the list is refreshed.
  Future<void> _navigateToAddItem() async {
    final newItem = await Navigator.of(context).push<PurchaseItemModel>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );
    if (newItem != null) {
      await _addItem(
          newItem); // Adds the new item to the list after returning from the page.
    }
  }

  /// Displays a snackbar with an (error) message.
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

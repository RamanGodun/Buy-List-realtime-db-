import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../../domain/models/purchase_model.dart';
import '../../domain/services/api_service.dart';

/// A widget that represents a single item in the shopping list.
/// This widget is dismissible and allows for actions like deleting the item or marking it as purchased.
class ListItemWidget extends StatefulWidget {
  final PurchaseItemModel item;
  final TextTheme textTheme;
  final ApiService apiService; // used for network operations
  final ValueNotifier<List<PurchaseItemModel>>
      itemsNotifier; //  for managing the items' list
  final ValueNotifier<bool> isLoading; //  for tracking loading state.
  final Function(String message)
      showErrorMessage; //  for  error messages' showing

  const ListItemWidget({
    super.key,
    required this.item,
    required this.textTheme,
    required this.apiService,
    required this.itemsNotifier,
    required this.isLoading,
    required this.showErrorMessage,
  });

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item
          .id), // Unique key based on the item's ID for identifying the dismissible widget.

      // Action triggered when the item is dismissed (swiped away).
      onDismissed: (direction) async {
        widget.isLoading.value =
            true; // Start loading state while item is being removed.
        try {
          await widget.apiService
              .removeItem(widget.item.id!); // Remove the item using the API.

          // Update the item list by filtering out the removed item.
          widget.itemsNotifier.value = widget.itemsNotifier.value
              .where((item) => item.id != widget.item.id)
              .toList();
        } catch (error) {
          // Show error message if item removal fails.
          widget.showErrorMessage(Constants.removeItemErrorMessage);
        } finally {
          widget.isLoading.value =
              false; // Stop loading state once operation completes.
        }
      },

      // Background widget shown during the swipe-to-dismiss action (a red delete icon).
      background: Container(
        color: Constants.dismissibleBackgroundColor.withOpacity(0.2),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      // The actual content of the list item, displayed as a ListTile.
      child: ListTile(
        title: Text(
          widget.item.name,
          style: widget.textTheme.bodyLarge?.copyWith(
              color: widget.item.category
                  .color), // Style the text based on category color.
        ),

        // Checkbox used to mark an item as purchased (not persistent in this implementation).
        leading: Checkbox(
          value: false, // The checkbox is always unchecked by default.

          // Action when the checkbox is clicked.
          onChanged: (bool? value) async {
            if (value == true) {
              // If the checkbox is checked, proceed to remove the item.
              widget.isLoading.value = true; // Start loading state.
              try {
                await widget.apiService.removeItem(
                    widget.item.id!); // Remove the item using the API.

                // Update the item list by filtering out the removed item.
                widget.itemsNotifier.value = widget.itemsNotifier.value
                    .where((item) => item.id != widget.item.id)
                    .toList();
              } catch (error) {
                // Show error message if item removal fails.
                widget.showErrorMessage(Constants.removeItemErrorMessage);
              } finally {
                widget.isLoading.value =
                    false; // Stop loading state once operation completes.
              }
            }
          },
        ),

        // Trailing widget displaying the quantity of the item.
        trailing: Text(
          widget.item.quantity.toString(),
          style: widget.textTheme.bodyMedium?.copyWith(
              color:
                  widget.item.category.color), // Style with the category color.
        ),
      ),
    );
  }
}

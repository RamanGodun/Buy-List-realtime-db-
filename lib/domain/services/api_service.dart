import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/purchase_model.dart';

part 'api_service.g.dart'; // Generated code for Retrofit

/// The `ApiService` is an interface that defines the RESTful API communication for the app.
///
/// - This service uses **Dio** for making HTTP requests.
/// - **Retrofit** is used for automatic code generation based on the API structure.
/// - The methods represent CRUD (Create, Read, Delete) operations that interact with a Firebase Realtime Database.

@RestApi()
abstract class ApiService {
  /// Factory constructor to initialize the service with Dio for making HTTP requests.
  /// - It accepts a `Dio` instance and an optional `baseUrl` parameter for overriding the default base URL.
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  /// Fetches all items from the shopping list stored in the Firebase Realtime Database.
  ///
  /// - **@GET**: Represents an HTTP GET request to fetch data from `/shopping-list.json`.
  /// - Returns a `Future<Map<String, PurchaseItemModel>>` where each item is mapped by its ID.
  @GET('/shopping-list.json')
  Future<Map<String, PurchaseItemModel>> fetchItems();

  /// Adds a new item to the shopping list.
  ///
  /// - **@POST**: Represents an HTTP POST request to create a new entry in `/shopping-list.json`.
  /// - The `newItem` parameter is sent as the request body in JSON format.
  /// - This method returns a `Future<void>` since the response doesn't need to return any data.
  @POST('/shopping-list.json')
  Future<void> addItem(@Body() PurchaseItemModel newItem);

  /// Removes an item from the shopping list.
  ///
  /// - **@DELETE**: Represents an HTTP DELETE request to remove an entry at `/shopping-list/{id}.json`.
  /// - The `id` parameter is used to identify which item to delete in the database.
  /// - This method returns a `Future<void>` indicating that the operation doesn't return a result.
  @DELETE('/shopping-list/{id}.json')
  Future<void> removeItem(@Path('id') String id);
}

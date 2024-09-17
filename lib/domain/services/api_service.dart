import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/purchase_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/shopping-list.json')
  Future<Map<String, PurchaseItemModel>> fetchItems();

  @POST('/shopping-list.json')
  Future<void> addItem(@Body() PurchaseItemModel newItem);

  @DELETE('/shopping-list/{id}.json')
  Future<void> removeItem(@Path('id') String id);
}

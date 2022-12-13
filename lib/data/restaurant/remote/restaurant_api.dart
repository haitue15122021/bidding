import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/response/restaurant_list_response.dart';

part 'restaurant_api.g.dart';
@RestApi()
abstract class RestaurantApi {
  factory RestaurantApi(Dio dio, {String baseUrl}) = _RestaurantApi;

  @GET('homework')
  Future<RestaurantListResponse> getRestaurants();

}
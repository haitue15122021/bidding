

import 'package:dio/dio.dart';
import '../restaurant.dart';
import '../../utils/utils.dart';

import '../../../domain/restaurant/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  RestaurantApi restaurantApi;

  RestaurantRepositoryImpl({this.restaurantApi});


  @override
  Future<RestaurantListResponse> getRestaurants() async{
    try {
      final response  = await restaurantApi.getRestaurants();
      return response;
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      throw Exception('Unexpected Exception $e');
    }

  }

  @override
  Future<RestaurantListResponse> searchRestaurants(String keyWord) async {
    /// We will develop this feature later
   return null;
  }


}

import '../../../data/restaurant/restaurant.dart';

abstract class RestaurantRepository {
  Future<RestaurantListResponse> getRestaurants();
  Future<RestaurantListResponse> searchRestaurants(String keyWord);
}
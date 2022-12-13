
import '../../../data/restaurant/restaurant.dart';

import '../restaurant.dart';

class RestaurantUsecase {
  final  RestaurantRepository restaurantRepository;
  const RestaurantUsecase({this.restaurantRepository});

  Future<RestaurantListResponse> getRestaurants(){
    return restaurantRepository.getRestaurants();
  }


}
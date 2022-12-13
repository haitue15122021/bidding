import 'package:flutter/material.dart';
import '../../domain/restaurant/entities/restaurant_entity.dart';
import 'ui/restaurant_detail_screen.dart';

class RestaurantDetailRoute {
  static Widget route({@required RestaurantEntity arg}) =>
      RestaurantDetailScreen(
        restaurantEntity: arg,
      );
}

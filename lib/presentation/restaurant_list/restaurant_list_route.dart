import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/domain/restaurant/restaurant.dart';

import '../../utils/di/service_locator.dart';
import 'bloc/restaurant_bloc.dart';
import 'ui/restaurant_list_screen.dart';

class RestaurantListRoute {
  static Widget get route => BlocProvider(
        create: (_) => RestaurantBloc(
          restaurantUsecase: RestaurantUsecase(
              restaurantRepository: getIt.get<RestaurantRepository>()),
        ),
        child: const RestaurantListScreen(),
      );
}

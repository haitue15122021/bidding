import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/data/restaurant/model/response/restaurant_list_response.dart';

import '../../../data/restaurant/model/response/restaurant.dart';
import '../../../data/utils/utils.dart';
import '../../../domain/restaurant/entities/restaurant_entity.dart';
import '../../../domain/restaurant/restaurant.dart';
import '../../../generated/l10n.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantUsecase _restaurantUsecase;

  RestaurantBloc({RestaurantUsecase restaurantUsecase})
      : _restaurantUsecase = restaurantUsecase,
        super(const RestaurantInitState());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is LoadRestaurantsEvent) {
      yield* _mapLoadRestaurantEventToState(event);
    }
  }

  Stream<RestaurantState> _mapLoadRestaurantEventToState(
      LoadRestaurantsEvent event) async* {
    try {
      yield RestaurantsLoadingState(isRefresh: event.isRefresh);
      RestaurantListResponse response =
          await _restaurantUsecase.getRestaurants();
      List<RestaurantEntity> restaurants =
          response.restaurants.map((e) => e.entity).toList();
      restaurants
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      yield RestaurantLoadedSuccessState(restaurants: restaurants);
    } on ApiException catch (e) {
      yield RestaurantsLoadErrorState(errorMessage: e.errorMessage);
    } on Exception catch (_) {
      yield RestaurantsLoadErrorState(
          errorMessage: S.current.connectionProblem);
    }
  }
}

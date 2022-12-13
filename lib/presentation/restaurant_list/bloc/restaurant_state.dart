part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {
  const RestaurantState();
  @override
  List<Object> get props => [];
}

class RestaurantInitState extends RestaurantState {
  const RestaurantInitState();
}

class RestaurantsLoadingState extends RestaurantState {
  final bool isRefresh;
  const RestaurantsLoadingState({
    this.isRefresh,
  });
  @override
  List<Object> get props => [isRefresh];
}

class RestaurantLoadedSuccessState extends RestaurantState {
  final List<RestaurantEntity> restaurants;
  const RestaurantLoadedSuccessState({
    this.restaurants,
  });

  @override
  List<Object> get props => [restaurants];
}


class RestaurantsLoadErrorState extends RestaurantState {
  final String errorMessage;
  const RestaurantsLoadErrorState({
    this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

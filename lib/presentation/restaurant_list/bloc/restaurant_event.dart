part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurantsEvent extends RestaurantEvent {
  final bool isRefresh;
  const LoadRestaurantsEvent({
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [isRefresh];
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_management/data/restaurant/model/response/restaurant_list_response.dart';
import 'package:restaurant_management/data/restaurant/restaurant.dart';
import 'package:restaurant_management/domain/restaurant/restaurant.dart';
import 'package:restaurant_management/presentation/restaurant_list/bloc/restaurant_bloc.dart';

import '../../../utilities/mocks.dart';
import '../../../utilities/test_utilities.dart';

void main() {
  RestaurantUsecase restaurantUseCaseMock;

  final restaurantListResponse = RestaurantListResponse([
    Restaurant('Go Noodle House', 'Mon-Sun 11:30 am - 9:00 pm'),
    Restaurant('Village Park',
        'Mon-Thu, Sun 11:30 am - 10:00 pm  / Fri-Sat 11:30 am - 11:00 pm'),
    Restaurant('Lan Je Steamed Fish Restaurant',
        'Mon-Fri 10:30 am - 9:30 pm  / Sat-Sun 10:00 am - 9:30 pm'),
    Restaurant('Sushi Mentai', 'Mon-Sun 11:00 am - 11:00 pm'),
    Restaurant('Tong Palace',
        'Mon-Fri 9:00 am - 9:30 pm  / Sat-Sun 9:00 am - 10:00 pm'),
  ]);
  List<RestaurantEntity> restaurantEntities;


  setUp(() async{
    await TestUtilities.setupLocalization();
    restaurantUseCaseMock = RestaurantUsecaseMock();
    restaurantEntities =   restaurantListResponse.restaurants.map((e) => e.entity).toList();
    restaurantEntities.sort((a,b)=>a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  });





  blocTest(
    'Test restaurant bloc yield the right state when usecase return data (refresh = false)',
    build: () {
      when(() =>restaurantUseCaseMock.getRestaurants())
          .thenAnswer((_) async => restaurantListResponse);
      return RestaurantBloc(restaurantUsecase: restaurantUseCaseMock);
    },
    act: (bloc) => bloc.add(const LoadRestaurantsEvent(isRefresh: false)),
    expect: () => [
      const RestaurantsLoadingState(isRefresh: false),
      RestaurantLoadedSuccessState(restaurants: restaurantEntities)
    ],
  );

  blocTest(
    'Test restaurant bloc yield the right state when usecase return data (refresh = true)',
    build: () {
      when(() =>restaurantUseCaseMock.getRestaurants())
          .thenAnswer((_) async => restaurantListResponse);
      return RestaurantBloc(restaurantUsecase: restaurantUseCaseMock);
    },
    act: (bloc) => bloc.add(const LoadRestaurantsEvent(isRefresh: true)),
    expect: () => [
      const RestaurantsLoadingState(isRefresh: true),
      RestaurantLoadedSuccessState(restaurants: restaurantEntities)
    ],
  );



  blocTest(
    'Test restaurant bloc yield the right state with an error (refresh = true)',
    build: () {
      when(() =>restaurantUseCaseMock.getRestaurants())
          .thenAnswer((_) => throw Exception());
      return RestaurantBloc(restaurantUsecase: restaurantUseCaseMock);
    },
    act: (bloc) => bloc.add(const LoadRestaurantsEvent(isRefresh: true)),
    expect: () => [
      const RestaurantsLoadingState(isRefresh: true),
      const RestaurantsLoadErrorState(errorMessage:'There are some problems with the connection. Please try again')
    ],
  );

  blocTest(
    'Test restaurant bloc yield the right state with an error (refresh = false)',
    build: () {
      when(() =>restaurantUseCaseMock.getRestaurants())
          .thenAnswer((_) => throw Exception());
      return RestaurantBloc(restaurantUsecase: restaurantUseCaseMock);
    },
    act: (bloc) => bloc.add(const LoadRestaurantsEvent(isRefresh: false)),
    expect: () => [
      const RestaurantsLoadingState(isRefresh: false),
      const RestaurantsLoadErrorState(errorMessage:'There are some problems with the connection. Please try again')
    ],
  );








}

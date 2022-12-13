

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_management/data/restaurant/model/response/restaurant.dart';
import 'package:restaurant_management/data/restaurant/model/response/restaurant_list_response.dart';
import 'package:restaurant_management/data/restaurant/remote/restaurant_api.dart';
import 'package:restaurant_management/data/utils/utils.dart';
import 'package:restaurant_management/data/restaurant/repository/restaurant_repository_impl.dart';

import '../../utilities/mocks.dart';

void main(){
  RestaurantApi restaurantApiMock;
  setUp((){
    restaurantApiMock = RestaurantApiMock();
  });

  test('Test if api return restaurant list, repository will return expected data',() async{
    var restaurantListResponse = RestaurantListResponse(
      [
        Restaurant(
          'Go Noodle House',
          'Mon-Sun 11:30 am - 9:00 pm'
        ),
        Restaurant(
            'Village Park',
            'Mon-Thu, Sun 11:30 am - 10:00 pm  / Fri-Sat 11:30 am - 11:00 pm'
        ),
        Restaurant(
            'Lan Je Steamed Fish Restaurant',
            'Mon-Fri 10:30 am - 9:30 pm  / Sat-Sun 10:00 am - 9:30 pm'
        ),
        Restaurant(
            'Sushi Mentai',
            'Mon-Sun 11:00 am - 11:00 pm'
        ),
        Restaurant(
            'Tong Palace',
            'Mon-Fri 9:00 am - 9:30 pm  / Sat-Sun 9:00 am - 10:00 pm'
        ),
      ]
    );

    when(()=>restaurantApiMock.getRestaurants())
    .thenAnswer((_) async =>  restaurantListResponse);

    final repository = RestaurantRepositoryImpl(restaurantApi: restaurantApiMock);
    expect(await repository.getRestaurants(), restaurantListResponse);
  });


  test(
    'Test if api throw Exception, function will throw Exception',
        () async {
      when(() => restaurantApiMock.getRestaurants())
          .thenThrow(Exception());
      final repository = RestaurantRepositoryImpl(restaurantApi: restaurantApiMock);
      expect(
            repository.getRestaurants,
        throwsA(
          predicate((e) => e is Exception),
        ),
      );
    },
  );

  test(
    'Test if api throw DioError, function will throw ApiException',
        () async {
      when(() => restaurantApiMock.getRestaurants())
          .thenThrow(DioError(
        type: DioErrorType.RESPONSE,
        response: Response(
          data: StandardError('error message', 400, '400').toJson(),
        ),
      ));
      final repository = RestaurantRepositoryImpl(restaurantApi: restaurantApiMock);
      expect(
            repository.getRestaurants,
        throwsA(
          predicate((e) => e is ApiException),
        ),
      );
    },
  );
}
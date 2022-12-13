
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_management/data/restaurant/restaurant.dart';
import 'package:restaurant_management/domain/restaurant/repositories/restaurant_repository.dart';
import 'package:restaurant_management/domain/restaurant/restaurant.dart';

import '../../utilities/mocks.dart';

void main() {
  RestaurantRepository restaurantRepositoryMock;
  setUp(() {
    restaurantRepositoryMock = RestaurantRepositoryMock();
  });

  test(
      'Test if repository return restaurant list, usecase will return expected data', () async {
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

    when(() => restaurantRepositoryMock.getRestaurants())
        .thenAnswer((_) async => restaurantListResponse);

    final useCase = RestaurantUsecase(
        restaurantRepository: restaurantRepositoryMock);
    expect(await useCase.getRestaurants(), restaurantListResponse);
  });


}


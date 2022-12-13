

import 'package:mocktail/mocktail.dart';
import 'package:restaurant_management/data/restaurant/restaurant.dart';
import 'package:restaurant_management/domain/restaurant/repositories/restaurant_repository.dart';
import 'package:restaurant_management/domain/restaurant/restaurant.dart';

class RestaurantApiMock extends Mock implements RestaurantApi{}
class RestaurantRepositoryMock extends Mock implements RestaurantRepository{}
class RestaurantUsecaseMock extends Mock implements RestaurantUsecase{}
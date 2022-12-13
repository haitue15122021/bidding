import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../core/core.dart';
import '../../data/restaurant/remote/restaurant_api.dart';
import '../../data/utils/utils.dart';
import '../../domain/restaurant/repositories/restaurant_repository.dart';
import '../../data/restaurant/repository/restaurant_repository_impl.dart';
import '../../domain/restaurant/restaurant.dart';


GetIt getIt = GetIt.instance;

Future setupLocator() async {
  await _registerAppComponents();
  _registerNetworkComponents();
  _registerRepository();

}

Future _registerAppComponents() async {
  var sharedPreferencesManager =
      await SharedPreferencesManager.getInstance();
  getIt.registerSingleton(sharedPreferencesManager);
}

void _registerNetworkComponents() {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 10000,
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(),
    TokenInterceptor(),
    PrettyDioLogger(
      requestHeader: true,
      responseBody: true,
      requestBody: true,
      responseHeader: true,
    ),
  ]);

  getIt.registerSingleton(dio);

  getIt.registerSingleton(
    RestaurantApi(dio),
  );
}

void _registerRepository() {
  getIt.registerFactory<RestaurantRepository>(() => RestaurantRepositoryImpl(
        restaurantApi: getIt.get<RestaurantApi>(),
      ));
}


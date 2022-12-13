
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../core/core.dart';
import '../../../utils/di/service_locator.dart';

import '../shared_pref_manager.dart';


class TokenInterceptor extends InterceptorsWrapper {
  static const List<int> unauthorizedTokenCodes = [401];

  @override
  Future onError(DioError error) async {
    var _dio = getIt.get<Dio>();
    var sharedPrefManager = getIt<SharedPreferencesManager>();
    var accessToken = sharedPrefManager.getString(SharedPreferenceKey.keyAccessToken);
    var refreshToken = sharedPrefManager.getString(SharedPreferenceKey.keyRefreshToken);
    // user not logged in, no need to refresh token
    if (accessToken == null &&
        refreshToken == null) {
      return error;
    }

    final hasNoResponse = error.response == null;
    final errorIsResponse = error.type != DioErrorType.RESPONSE;
    final isTokenExpiredError =
        unauthorizedTokenCodes.contains(error.response.statusCode);
    if (hasNoResponse || errorIsResponse || !isTokenExpiredError) {
      return;
    }

    try {
      var request = error.response.request;

      /// Dio is locked, some api is doing refresh token at this point.
      /// So just try to request the api again with retry count 1.
      /// On token refresh, this key will be removed from headers anyway.
      if (_dio.interceptors.requestLock.locked) {
        return _dio.request(request.path, options: request);
      }
      _dio.lock();
      // create a new instance of Dio so it does not trigger this interceptor and others
      var refreshTokenDio =
          Dio(BaseOptions(baseUrl: apiBaseUrl));
      refreshTokenDio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true));

      ///Call api to refresh token and save access-token to SharedPref memory
      ///......
      ///End Call api to refresh token and save access-token to SharedPref memory
      _dio.unlock();
      return _dio.request(request.path, options: request);
    } catch (e) {
      // This cannot be done in finally block, with this in finally block,
      // the pending api with old refresh token will proceed and will cause
      // user logged out.
      _dio.unlock();
      return null;
    }
  }

}

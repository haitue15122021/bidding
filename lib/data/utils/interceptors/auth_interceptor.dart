import 'package:dio/dio.dart';

import '../../../utils/di/service_locator.dart';
import '../shared_pref_manager.dart';

class AuthInterceptor extends InterceptorsWrapper {
  static const String X_API_KEY = 'x-api-key';
  static const String ACCESS_TOKEN = 'access-token';

  @override
  Future onRequest(RequestOptions options) async {
    options.headers['Accept'] = 'application/json';
    var sharedPrefManager = getIt<SharedPreferencesManager>();
    var accessToken = sharedPrefManager.getString(SharedPreferenceKey.keyAccessToken);
    if (accessToken!=null && accessToken.isNotEmpty) {
      options.headers[ACCESS_TOKEN] = accessToken;
    }
    return super.onRequest(options);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestaurantApi implements RestaurantApi {
  _RestaurantApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<RestaurantListResponse> getRestaurants() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('homework',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RestaurantListResponse.fromJson(_result.data);
    return value;
  }
}

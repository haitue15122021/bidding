// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantListResponse _$RestaurantListResponseFromJson(
    Map<String, dynamic> json) {
  return RestaurantListResponse(
    (json['restaurants'] as List)
        .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestaurantListResponseToJson(
        RestaurantListResponse instance) =>
    <String, dynamic>{
      'restaurants': instance.restaurants,
    };

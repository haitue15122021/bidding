
import 'package:json_annotation/json_annotation.dart';
import 'restaurant.dart';

part 'restaurant_list_response.g.dart';

@JsonSerializable(nullable: false)
class RestaurantListResponse{
  List<Restaurant> restaurants;
  RestaurantListResponse(this.restaurants);

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantListResponseToJson(this);

  factory RestaurantListResponse.fromMap(Map<String, dynamic> json) =>
      RestaurantListResponse.fromJson(json);
  Map<String, dynamic> toMap() => toJson();

}
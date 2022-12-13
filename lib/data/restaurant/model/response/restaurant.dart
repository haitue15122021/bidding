

import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/restaurant/entities/restaurant_entity.dart';
part 'restaurant.g.dart';

@JsonSerializable(nullable: false)
class Restaurant{
  String name;
  String operatingHours;

  Restaurant(this.name,this.operatingHours);

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  factory Restaurant.fromMap(Map<String, dynamic> json) =>
      Restaurant.fromJson(json);

  Map<String, dynamic> toMap() => toJson();

}

extension RestaurantExt on Restaurant {
  RestaurantEntity get entity => RestaurantEntity(
    name: name,
    operatingHours: operatingHours
  );
}
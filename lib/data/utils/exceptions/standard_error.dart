import 'package:json_annotation/json_annotation.dart';

part 'standard_error.g.dart';

@JsonSerializable(nullable: false)
class StandardError {
  String message;
  int statusCode;
  String errorCode;

  StandardError(this.message, this.statusCode, this.errorCode);

  factory StandardError.fromJson(Map<String, dynamic> json) =>
      _$StandardErrorFromJson(json);
  Map<String, dynamic> toJson() => _$StandardErrorToJson(this);
}

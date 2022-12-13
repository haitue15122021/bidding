// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardError _$StandardErrorFromJson(Map<String, dynamic> json) {
  return StandardError(
    json['message'] as String,
    json['statusCode'] as int,
    json['errorCode'] as String,
  );
}

Map<String, dynamic> _$StandardErrorToJson(StandardError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'errorCode': instance.errorCode,
    };

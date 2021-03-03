// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response-data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return ResponseData(
    json['status'] as bool,
    json['message'] as String,
    json['data'],
    json['pagination'],
  );
}

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

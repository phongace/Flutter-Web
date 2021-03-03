import 'package:json_annotation/json_annotation.dart';

part 'response-data.g.dart';

@JsonSerializable()
class ResponseData {
  bool status;

  String message;

  dynamic data;

  dynamic pagination;

  ResponseData(this.status, this.message, this.data, this.pagination);

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

  @override
  String toString() {
    return 'ResponseData {status: $status, message: $message, data: $data, pagination: $pagination}';
  }
}

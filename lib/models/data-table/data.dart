import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  int id;

  String name;

  String username;

  String email;

  String address;

  String phone;

  String website;

  String company;

  Data({this.id, this.name, this.username, this.email, this.address, this.phone, this.website, this.company});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

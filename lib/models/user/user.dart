import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int userId;

  String username;

  String password;

  String rePassword;

  User({this.userId, this.username, this.password, this.rePassword});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User {userId: $userId, username: $username, password: $password}';
  }
}

part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['userId'] as int,
    username: json['username'] as String,
    password: json['password'] as String,
    rePassword: json['rePassword'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'password': instance.password,
      'rePassword': instance.rePassword,
    };

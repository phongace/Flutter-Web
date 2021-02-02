import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Comment {
  int postId;

  int id;

  String name;

  String email;

  String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  factory Comment.formJson(Map<String, dynamic> json) => Comment(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };
}

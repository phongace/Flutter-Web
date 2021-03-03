class UserLoginForm {
  String email;
  String password;

  UserLoginForm({this.email, this.password});

  factory UserLoginForm.fromJson(Map<String, dynamic> json) {
    return UserLoginForm(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class User {
  String userName;
  String password;
  String accessToken;

  User({this.userName, this.password, this.accessToken});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(accessToken: json['access_token']);
  }
}

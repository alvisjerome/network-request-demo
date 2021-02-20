import 'package:meta/meta.dart';

//model class for users
class User {
  final int id;
  final String name;
  final String email;

  const User({@required this.id, @required this.name, @required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["id"], name: json["name"], email: json["email"]);
  }
}

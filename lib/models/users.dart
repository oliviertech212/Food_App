// models adre used when you are working with api data
// example when you want to render data based on that model
import "package:path/path.dart";

class User {
  final String? username;
  final String email;
  final String password;

  final String? createdAt = DateTime.now().toIso8601String();
  final String? updatedAt;

  User(
      {this.username,
      required this.email,
      required this.password,
      String? updatedAt})
      : updatedAt = updatedAt ?? DateTime.now().toIso8601String() {
    if (email.isEmpty) {
      throw ArgumentError('email cannot be empty');
    }
    if (password.isEmpty) {
      throw ArgumentError('password cannot be empty');
    }
  }

  Map<String, Object?> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     username: json['name'],
  //     email: json['email'],
  //     password: json['password'],
  //     updatedAt: json['updated_at'],
  //   );
  // }
}


// and fetchinddatafrom api
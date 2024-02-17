// models adre used when you are working with api data
// example when you want to render data based on that model

class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}


// and fetchinddatafrom api
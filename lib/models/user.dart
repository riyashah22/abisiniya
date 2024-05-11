import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String password;
  final String password_confirmation;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.phone,
      required this.password,
      required this.password_confirmation});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'surname': surname});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': password_confirmation});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      password_confirmation: map['password_confirmation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

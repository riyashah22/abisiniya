import 'dart:convert';
import 'dart:ffi';

class User {
  final num id;
  final String name;
  final String token;
  final String token_type;

  User({
    required this.id,
    required this.name,
    required this.token,
    required this.token_type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'token': token});
    result.addAll({'token_type': token_type});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      token: map['token'] ?? '',
      token_type: map['token_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

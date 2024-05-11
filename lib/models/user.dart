import 'dart:convert';

class User {
  final num userId;
  final String name;
  final String token;
  final String token_type;

  User({
    required this.userId,
    required this.name,
    required this.token,
    required this.token_type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': userId});
    result.addAll({'name': name});
    result.addAll({'token': token});
    result.addAll({'token_type': token_type});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] ?? 0,
      name: map['name'] ?? '',
      token: map['token'] ?? '',
      token_type: map['token_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

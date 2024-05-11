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
}

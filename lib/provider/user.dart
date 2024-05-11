import 'package:abisiniya/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<User>((ref) {
  return User(
      id: "",
      name: "",
      surname: "",
      email: "",
      phone: "",
      password: "",
      password_confirmation: "");
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier(User initialState) : super(initialState);

  void setUser(String user) {
    state = User.fromJson(user);
  }
}

// To call Use final user = ref.watch(userProvider);

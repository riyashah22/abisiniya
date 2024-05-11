import 'package:abisiniya/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<User>((ref) {
  return User(
    id: 0,
    name: "",
    token: "",
    token_type: "",
  );
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier(User initialState) : super(initialState);
}

// To call Use final user = ref.watch(userProvider);

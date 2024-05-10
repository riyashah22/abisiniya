import 'package:abisiniya/screens/auth/signup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            const Text("Login Screen"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignupScreen.routeName);
                },
                child: const Text("Sign up?"))
          ],
        ),
      ),
    );
  }
}

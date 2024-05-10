import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/singup-screen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            const Text("Sign up Screen"),
          ],
        ),
      ),
    );
  }
}

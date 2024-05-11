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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 48,
              ),
              Text(
                "Craete An Account",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ready to roam? Join us today!",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Divider(
                  height: 10,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

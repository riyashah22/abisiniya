import 'package:abisiniya/screens/auth/signup.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthServices authServices = AuthServices();

  void login() async {
    authServices.login(context, email.text, password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              Image.network(
                "https://play-lh.googleusercontent.com/K3nH-iUkFXZBQ4ObTGeXDyZcyZ6vUwmk3MXFc8xG2VRPojLp-yWDkRtXoYhOZUi3B8g=w240-h480-rw",
                height: 224,
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                "Sign In to continue",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
              ),
              SizedBox(
                height: 16,
              ),
              Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    TextFieldInput(
                      textEditingController: email,
                      label: 'Username',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16.0),
                    TextFieldInput(
                      textEditingController: password,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: login,
                      icon: Icon(Icons.arrow_right_alt_outlined),
                      label: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        // Add styling if needed
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0), // Adjust padding as needed
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                  child: const Text("Sign up?"))
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController textEditingController;

  const TextFieldInput(
      {Key? key,
      required this.label,
      required this.icon,
      this.obscureText = false,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

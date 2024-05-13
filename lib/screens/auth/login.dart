import 'package:abisiniya/screens/auth/signup.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Logging in..."),
            ],
          ),
        );
      },
    );

    // Simulate a delay for 5 seconds
    await Future.delayed(const Duration(seconds: 1));

    // Dismiss the loading dialog
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              const CircleAvatar(
                minRadius: 124,
                backgroundImage: NetworkImage(
                  "https://play-lh.googleusercontent.com/K3nH-iUkFXZBQ4ObTGeXDyZcyZ6vUwmk3MXFc8xG2VRPojLp-yWDkRtXoYhOZUi3B8g=w240-h480-rw",
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                "Welcome Back",
                style: GoogleFonts.roboto(
                  textStyle:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Theme.of(context).primaryColor,
                          ),
                ),
              ),
              Text(
                "Please login to your account",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      // letterSpacing: 0.5,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    TextFieldInput(
                      validator: (val) {
                        List<String> temp;
                        temp = val!.split("@");
                        print(temp.length);
                        if (val.isEmpty) {
                          return 'Please Enter Username';
                        } else if (temp.length != 2) {
                          return 'Enter valid email address';
                        }
                        return null;
                      },
                      textEditingController: email,
                      label: 'Username',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16.0),
                    TextFieldInput(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Password';
                        } else if (val.length < 8) {
                          return 'Please Enter Valid Passowrd';
                        }
                        return null;
                      },
                      textEditingController: password,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (loginFormKey.currentState!.validate()) {
                          login();
                        }
                      },
                      icon: const Icon(Icons.arrow_right_alt_outlined),
                      label: const Text("Login"),
                      style: ElevatedButton.styleFrom(
                        // Add styling if needed
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0), // Adjust padding as needed
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                    child: Text("Sign up?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor,
                            )),
                  ),
                ],
              ),
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
  final String? Function(String?) validator;

  const TextFieldInput(
      {Key? key,
      required this.label,
      required this.icon,
      this.obscureText = false,
      required this.validator,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
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

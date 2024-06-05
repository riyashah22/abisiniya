import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/singup-screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthServices authServices = AuthServices();

  void signup() async {
    authServices.signup(
      context,
      nameController.text,
      surnameController.text,
      emailController.text,
      phoneController.text,
      passwordController.text,
      confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarSecondaryScreen(context, "Welcome to Abisiniya"),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Create An Account",
                  style: GoogleFonts.roboto(
                    color: CustomColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Ready to roam? Join us today!",
                  style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Divider(
                    height: 10,
                    color: CustomColors.primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputTextField(
                          label: 'Name',
                          hintText: 'Enter your name',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8.0),
                        InputTextField(
                          label: 'Surname',
                          hintText: 'Enter your surname',
                          controller: surnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your surname';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8.0),
                        InputTextField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Phone Number',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: CustomColors.primaryColor),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        InputTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          controller: passwordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        InputTextField(
                          label: 'Confirm Password',
                          hintText: 'Re-enter your password',
                          controller: confirmPasswordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                            CustomColors.primaryColor,
                          )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signup();
                            }
                          },
                          child: Center(
                              child: Text(
                            'Create Account',
                            style: GoogleFonts.roboto(
                              color: CustomColors.lightPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          )),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: CustomColors.smokyBlackColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  color: CustomColors.primaryColor,
                                  letterSpacing: 0.5,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const InputTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primaryColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            obscureText: isPassword,
            validator: validator,
          ),
        ],
      ),
    );
  }
}

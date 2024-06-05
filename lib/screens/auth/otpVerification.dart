import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends StatefulWidget {
  static const String routeName = '/opt-screen';

  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  AuthServices authServices = AuthServices();

  void verifyOtp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Wrap(children: [
            Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Verifying OTP",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                    )),
              ],
            ),
          ]),
        );
      },
    );
    var result = await authServices.otpVerify(
        context, _emailController.text, _otpController.text);
    Navigator.pop(context);

    if (result == 0) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else if (result == 1) {
      showErrorMessage(context, "Invalid OTP");
    } else if (result == 2) {
      showErrorMessage(context, "User not found");
    } else {
      showErrorMessage(context, "Something went wrong...");
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    _emailController.text = email;
    return Scaffold(
      backgroundColor: CustomColors.lightPrimaryColor,
      appBar: CustomAppbarSecondaryScreen(context, "Verification"),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
          padding: const EdgeInsets.all(40.0),
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: const Offset(2.0, 0.0),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Verify Email",
                style: GoogleFonts.roboto(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "We have sent a verification code to your registered email address.",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.grey),
              ),
              const SizedBox(height: 36.0),
              TextFormField(
                enabled: email == "" ? true : false,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email ", // Editable if email not provided
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number, // For OTP input
                decoration: InputDecoration(
                  labelText: "OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  verifyOtp();
                },
                child: Text(
                  "Verify",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  foregroundColor: CustomColors.lightPrimaryColor,
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

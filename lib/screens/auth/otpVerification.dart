import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  static const String routeName = '/opt-screen';
  final String email; // Pass email as an argument (optional)

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  int _resendOtpCooldown = 60; // Optional cooldown in seconds for resend button

  @override
  void initState() {
    super.initState();
    // Pre-fill email if provided (optional)
    if (widget.email.isNotEmpty) {
      _emailController.text = widget.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 5.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Verify Email",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "We have sent a verification code to your registered email address.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText:
                      "Email (optional)", // Editable if email not provided
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
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Your verification logic using _emailController.text and _otpController.text
                    },
                    child: const Text("Verify"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _resendOtpCooldown > 0
                        ? null
                        : () {
                            // Your resend OTP logic
                            setState(() {
                              _resendOtpCooldown = 60; // Reset cooldown
                            });
                          },
                    child: Text(
                      _resendOtpCooldown > 0
                          ? 'Resend OTP (in $_resendOtpCooldown s)'
                          : 'Resend OTP',
                      style: TextStyle(
                          color: _resendOtpCooldown > 0
                              ? Colors.grey
                              : Colors.blue),
                    ),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          color: _resendOtpCooldown > 0
                              ? Colors.grey
                              : Colors.blue),
                    ),
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

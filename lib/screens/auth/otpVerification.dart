import 'dart:async';

import 'package:abisiniya/models/user.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/material.dart';

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
  int _resendOtpCooldown = 0;
  late Timer _resendOtpTimer;

  @override
  void initState() {
    super.initState();
    // Start the cooldown timer initially
    _startResendOtpCooldown();
  }

  @override
  void dispose() {
    _resendOtpTimer.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  void _startResendOtpCooldown() {
    _resendOtpCooldown = 60; // Set the cooldown time
    _resendOtpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendOtpCooldown > 0) {
          _resendOtpCooldown--; // Decrease the cooldown time by 1 second
        } else {
          _resendOtpTimer.cancel(); // Cancel the timer when cooldown reaches 0
        }
      });
    });
  }

  void _resendOtp() {
    _startResendOtpCooldown();
  }

  void verifyOtp() async {
    authServices.otpVerify(context, _emailController.text, _otpController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40.0),
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
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      verifyOtp();
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
                    onPressed: _resendOtpCooldown > 0 ? null : _resendOtp,
                    child: Text(
                      _resendOtpCooldown > 0
                          ? 'Resend OTP (in $_resendOtpCooldown s)'
                          : 'Resend OTP',
                      style: TextStyle(
                        color:
                            _resendOtpCooldown > 0 ? Colors.grey : Colors.blue,
                      ),
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

import 'dart:convert';

import 'package:abisiniya/bottom_navigation.dart';
import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/screens/auth/otpVerification.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthServices {
  void login(BuildContext context, String email, String password) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res = await http.post(
        Uri.parse(
            "https://www.abisiniya.com/api/v1/login?email=$email&password=$password"),
      );

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          print(jsonDecode(res.body)['data']['token']);
          // Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          // Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }

  void signup(BuildContext context, String name, String surname, String email,
      String phone, String password, String confirmPassword) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res = await http.post(
        Uri.parse(
            "https://www.abisiniya.com/api/v1/myregister?email=$email&password=$password&name=$name&surname=$surname&phone=$phone&password_confirmation=$confirmPassword"),
      );

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          print(jsonDecode(res.body));
          Navigator.of(context).pushNamed(OtpVerificationScreen.routeName);
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}

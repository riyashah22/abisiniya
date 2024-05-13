import 'dart:convert';
import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/user.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/screens/auth/otpVerification.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthServices {
  void login(BuildContext context, String email, String password) async {
    void handleHttpError(String errorMessage) {
      // showSnackBar(context, errorMessage);
      showErrorMessage(context, errorMessage);
    }

    try {
      http.Response res = await http.post(
        Uri.parse(
            "https://www.abisiniya.com/api/v1/login?email=$email&password=$password"),
      );
      print(jsonDecode(res.body)['data']['token']);

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          User user = User(
            userId: jsonDecode(res.body)['data']['userID'],
            name: jsonDecode(res.body)['data']['name'],
            token: jsonDecode(res.body)['data']['token'],
            token_type: jsonDecode(res.body)['data']['token_type'],
          );
          Provider.of<UserProvider>(context, listen: false).setUser(
            user,
          );

          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        onError: (errorMessage) {
          // showSnackBar(context, errorMessage); //new comment
          showErrorMessage(context, errorMessage);
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

      print(res.statusCode);
      jsonDecode(res.body);
      httpErrorHandle(
        response: res,
        onSuccess: () async {
          print(jsonDecode(res.body));
          Navigator.of(context).pushNamed(OtpVerificationScreen.routeName,
              arguments: {'email': email});
        },
        onError: (errorMessage) {
          showErrorMessage(context, errorMessage);
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }

  void otpVerify(
    BuildContext context,
    String email,
    String otp,
  ) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res = await http.post(
        Uri.parse(
            "https://www.abisiniya.com/api/v1/otpverify?email=$email&otp=$otp"),
      );

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          print(jsonDecode(res.body));
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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

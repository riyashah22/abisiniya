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
            "https://staging.abisiniya.com/api/v1/login?email=$email&password=$password"),
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
      // final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError("Enter correct Email or Password");
    }
  }

  void logout(BuildContext context, String token) async {
    void handleHttpError(String errorMessage) {
      // showSnackBar(context, errorMessage);
      showErrorMessage(context, errorMessage);
    }

    try {
      http.Response res = await http.post(
          Uri.parse("https://staging.abisiniya.com/api/v1/logout"),
          headers: {
            'Authorization': 'Bearer $token',
          });

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          User user = User(
            userId: 0,
            name: "",
            token: "",
            token_type: "",
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

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }

  void signup(BuildContext context, String name, String surname, String email,
      String phone, String password, String confirmPassword) async {
    void handleHttpError(String errorMessage) {
      showErrorMessage(context, errorMessage);
    }

    try {
      final data = {
        'name': name,
        'surname': surname,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmPassword,
      };

      final uri = Uri.parse("https://staging.abisiniya.com/api/v1/myregister");

      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      httpErrorHandle(
        response: res,
        onSuccess: () async {
          print(jsonDecode(res.body));
          Navigator.of(context).pushNamed(OtpVerificationScreen.routeName,
              arguments: {'email': email});
        },
        onError: (errorMessage) {
          showErrorMessage(context, "Error: ${res.statusCode}");
        },
      );
    } catch (e) {
      if (password != confirmPassword) {
        handleHttpError("Password is not matched");
      } else if (!isValidEmail(email)) {
        handleHttpError("Invalid Email");
      }
    }
  }

  Future<List<dynamic>?> userBookings(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse(
            "https://staging.abisiniya.com/api/v1/booking/apartment/mybookings"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['data'];
      } else {
        showErrorMessage(context, "Error: ${res.statusCode.toString()}");
      }
    } catch (e) {
      showErrorMessage(context, "Error 404");
    }
    return null;
  }

  Future<List<dynamic>?> userDetailBookings(
      BuildContext context, String id) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse(
            "https://staging.abisiniya.com/api/v1/booking/apartment/mybookingdetail/$id"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );

      if (res.statusCode == 200) {
        print(jsonDecode(res.body)['data']['booking'][0]);
        return [
          jsonDecode(res.body)['data']['booking'][0]['ownerDetail'],
          jsonDecode(res.body)['data']['booking'][0]['customerDetail']
              ['Payment Status'],
          jsonDecode(res.body)['data']['booking'][0]['price'],
          jsonDecode(res.body)['data']['booking'][0]['checkIn'],
          jsonDecode(res.body)['data']['booking'][0]['checkOut']
        ];
      } else {
        showSnackBar(context, 'Failed to load apartments');
      }
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
    return null;
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
          showSnackBar(context, "Otp Invalid");
        },
      );
    } catch (e) {
      handleHttpError("Invalid Otp");
    }
  }

  void contactUs(
    BuildContext context,
    String name,
    String email,
    String subject,
    String message,
  ) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      final data = {
        'name': name,
        'subject': subject,
        'email': email,
        'message': message,
      };

      final uri = Uri.parse("https://staging.abisiniya.com/api/common/contact");

      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          showSnackBar(context, "Form Submitted Successfully!");
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
}

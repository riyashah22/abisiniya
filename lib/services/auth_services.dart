import 'dart:convert';
import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/user.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthServices {
  Future<bool> login(
      BuildContext context, String email, String password) async {
    // void handleHttpError(String errorMessage) {
    //   // showSnackBar(context, errorMessage);
    //   showErrorMessage(context, errorMessage);
    // }

    try {
      http.Response res = await http.post(
          Uri.parse(
              "https://staging.abisiniya.com/api/v1/login?email=$email&password=$password"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
      // print(jsonDecode(res.body)['data']['token']);

      if (res.statusCode == 200) {
        User user = User(
          userId: jsonDecode(res.body)['data']['userID'],
          name: jsonDecode(res.body)['data']['name'],
          token: jsonDecode(res.body)['data']['token'],
          token_type: jsonDecode(res.body)['data']['token_type'],
        );
        Provider.of<UserProvider>(context, listen: false).setUser(
          user,
        );
        return true;
      } else if (res.statusCode == 404) {
        //if credentials are wrong
        return false;
      } else {
        return false;
      }

      // httpErrorHandle(
      //   response: res,
      //   onSuccess: () async {
      //     User user = User(
      //       userId: jsonDecode(res.body)['data']['userID'],
      //       name: jsonDecode(res.body)['data']['name'],
      //       token: jsonDecode(res.body)['data']['token'],
      //       token_type: jsonDecode(res.body)['data']['token_type'],
      //     );
      //     Provider.of<UserProvider>(context, listen: false).setUser(
      //       user,
      //     );
      //     Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      //     // return true;
      //   },
      //   onError: (errorMessage) {
      //     // showErrorMessage(context, errorMessage);
      //   },
      // );
    } catch (e) {
      /*
        status code - 404 (not found)
        such that won't go to onError()
       */
      // showErrorMessage(context, "Enter correct email or password");
      return false;
    }
  }

  Future<bool> logout(BuildContext context, String token) async {
    // void handleHttpError(String errorMessage) {
    //   // showSnackBar(context, errorMessage);
    //   showErrorMessage(context, errorMessage);
    // }

    try {
      http.Response res = await http.post(
          Uri.parse("https://staging.abisiniya.com/api/v1/logout"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

      if (res.statusCode == 200) {
        User user = User(
          userId: 0,
          name: "",
          token: "",
          token_type: "",
        );
        Provider.of<UserProvider>(context, listen: false).setUser(
          user,
        );
        return true;
      } else if (res.statusCode == 401) {
        return false;
      } else {
        return false;
      }

      // httpErrorHandle(
      //   response: res,
      //   onSuccess: () async {
      //     User user = User(
      //       userId: 0,
      //       name: "",
      //       token: "",
      //       token_type: "",
      //     );
      //     Provider.of<UserProvider>(context, listen: false).setUser(
      //       user,
      //     );

      //     Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      //   },
      //   onError: (errorMessage) {
      //     showErrorMessage(context, "Something went wrong");
      //   },
      // );
    } catch (e) {
      // showErrorMessage(context, "Something went wrong");
      return false;

      // final errorMessage = "Error occurred: ${e.toString()}";
      // handleHttpError(errorMessage);
    }
  }

  Future<bool> signup(
      BuildContext context,
      String name,
      String surname,
      String email,
      String phone,
      String password,
      String confirmPassword) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
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
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }

      // httpErrorHandle(
      //   response: res,
      //   onSuccess: () async {
      //     // print(jsonDecode(res.body));
      //     Navigator.of(context).pushNamed(OtpVerificationScreen.routeName,
      //         arguments: {'email': email});
      //   },
      //   onError: (errorMessage) {
      //     //  status code - 400 (bad request)
      //     showErrorMessage(context, errorMessage);
      //   },
      // );
    } catch (e) {
      // only excutes when there is error (404)
      // final errorMessage = "Error occurred: ${e.toString()}";
      // handleHttpError(errorMessage);

      return false;
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
        showSnackBar(context, 'Failed to load apartments');
      }
    } catch (e) {
      showErrorMessage(context, "Failed to load apartments.");
      // final errorMessage = "Error occurred: ${e.toString()}";
      // showSnackBar(context, errorMessage);
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
        showErrorMessage(context, 'Failed to load apartments');
      }
    } catch (e) {
      showErrorMessage(context, "Something went wrong");

      // final errorMessage = "Error occurred: ${e.toString()}";
      // showSnackBar(context, errorMessage);
    }
    return null;
  }

  Future<int> otpVerify(
    BuildContext context,
    String email,
    String otp,
  ) async {
    // void handleHttpError(String errorMessage) {
    //   showSnackBar(context, errorMessage);
    // }

    try {
      http.Response res = await http.post(
        Uri.parse(
            "https://staging.abisiniya.com/api/v1/otpverify?email=$email&otp=$otp"),
      );
      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        return 0;
      } else if (res.statusCode == 400) {
        return 1;
      } else if (res.statusCode == 404) {
        return 2;
      } else {
        return 3;
      }

      // httpErrorHandle(
      //   response: res,
      //   onSuccess: () async {
      //     print(jsonDecode(res.body));
      //     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      //   },
      //   onError: (errorMessage) {
      //     showErrorMessage(context, "Failed to generate OTP");
      //   },
      // );
    } catch (e) {
      // if (res.statusCode == 200) {
      //   return 0;
      // } else if (res.statusCode == 400) {
      //   return 1;
      // } else if (res.statusCode == 404) {
      //   return 2;
      // } else {
      //   return 3;
      // }
      return 3;
      // showErrorMessage(context, "Something went wrong");

      // final errorMessage = "Error occurred: ${e.toString()}";
      // handleHttpError(errorMessage);
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

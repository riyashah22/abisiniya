import 'dart:convert'; // Required for jsonDecode
import 'package:abisiniya/constants/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FlightServices {
  Future<List<String>> airlines(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://staging.abisiniya.com/api/v1/flight/airportlist",
        ),
      );

      List<String> airlines = [];

      httpErrorHandle(
        response: res,
        onSuccess: () {
          final decodedResponse = jsonDecode(res.body);
          if (decodedResponse['success']) {
            for (var airport in decodedResponse['data']) {
              airlines.add(airport['name']);
            }
          }
          print(airlines);
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );

      return airlines;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
      return [];
    }
  }
}

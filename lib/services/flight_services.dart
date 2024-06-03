import 'dart:convert'; // Required for jsonDecode
import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightServices {
  Future<void> flightRequest(
      BuildContext context,
      String from,
      String to,
      String fromDate,
      String toDate,
      String airline,
      String travel_class,
      String trip_option,
      String message) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      final request = {
        'from': from,
        'to': to,
        'airline': airline,
        'departure_date': fromDate,
        'return_date': toDate,
        'travel_class': travel_class,
        'trip_option': trip_option,
        'message': message,
      };

      final uri = Uri.parse(
        "https://staging.abisiniya.com/api/v1/flight/auth/userflight",
      );

      final res = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request),
      );

      httpErrorHandle(
        response: res,
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
        onSuccess: () {
          showSnackBar(context, "Flight Request Submitted");
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }

  Future<List<String>> airlines(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://staging.abisiniya.com/api/v1/flight/airlinelist",
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
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );

      return airlines;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
      return []; // Return an empty list on error
    }
  }

  Future<List<String>> airports(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://staging.abisiniya.com/api/v1/flight/airportlist",
        ),
      );

      List<String> airports = [];

      httpErrorHandle(
        response: res,
        onSuccess: () {
          final decodedResponse = jsonDecode(res.body);
          if (decodedResponse['success']) {
            for (var airport in decodedResponse['data']) {
              airports.add(airport['name']);
            }
          }
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );

      return airports;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
      return []; // Return an empty list on error
    }
  }
}

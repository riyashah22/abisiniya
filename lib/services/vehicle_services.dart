import 'dart:convert';

import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class VehicleServices {
  Future<List<Vehicle>> getAllVehicles(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://staging.abisiniya.com/api/v1/vehicle/list",
        ),
      );
      List<Vehicle> fetchedVehicles = [];
      // print(fetchedApartments);
      httpErrorHandle(
        response: res,
        onSuccess: () {
          var data = jsonDecode(jsonEncode(jsonDecode(res.body)['data']));
          // print(jsonDecode(res.body)['data'][0]['model']);
          for (var i = 0; i < data.length; i++) {
            Vehicle vehicle = Vehicle(
              name: jsonDecode(res.body)['data'][i]['name'].toString(),
              address: jsonDecode(res.body)['data'][i]['address'],
              city: jsonDecode(res.body)['data'][i]['city'],
              country: jsonDecode(res.body)['data'][i]['country'],
              make: jsonDecode(res.body)['data'][i]['make'],
              model: jsonDecode(res.body)['data'][i]['model'],
              year: jsonDecode(res.body)['data'][i]['year'],
              engineSize: jsonDecode(res.body)['data'][i]['engine_size'],
              fuelType: jsonDecode(res.body)['data'][i]['fuel_type'],
              weight: jsonDecode(res.body)['data'][i]['weight'],
              color: jsonDecode(res.body)['data'][i]['color'],
              transmission: jsonDecode(res.body)['data'][i]['transmission'],
              price: jsonDecode(res.body)['data'][i]['price'],
              status: jsonDecode(res.body)['data'][i]['status'],
              images: jsonDecode(res.body)['data'][i]['pictures'][0]
                  ['imageUrl'],
            );
            fetchedVehicles.add(vehicle);
          }
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );

      return fetchedVehicles;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
      return [];
    }
  }

  Future<List<dynamic>?> usersVehicles(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("https://www.abisiniya.com/api/v1/vehicle/auth/list"),
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
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
    return null;
  }

  void bookVehicle(BuildContext context, String start_date, String end_date, int vehicle_id) async {
    void handleHttpError(String errorMessage) {
      // showSnackBar(context, errorMessage);
      showErrorMessage(context, errorMessage);
    }
    final user = Provider.of<UserProvider>(context, listen: false).user;
    print(start_date.split(" ")[0]);
    try {
      http.Response res = await http.post(
        headers: {
          'Authorization': 'Bearer ${user.token}',
        },
        Uri.parse(
            "https://staging.abisiniya.com/api/v1/booking/vehicle/booking/authuser",),
            body: {
              "start_date": start_date.split(" ")[0],
              "end_date": end_date.split(" ")[0],
              "bookable_type": "Vehicle",
              "bookable_id": vehicle_id.toString(),
            }
      );

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          print("booking successful");

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
}

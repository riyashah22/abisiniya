import 'dart:convert';

import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/vehicles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleServices {
  Future<List<Vehicle>> getAllVehicles(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://www.abisiniya.com/api/v1/vehicle/list",
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
}

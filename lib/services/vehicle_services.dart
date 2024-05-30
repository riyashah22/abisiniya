import 'dart:convert';
import 'dart:io';

import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:path/path.dart';

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
        Uri.parse("https://staging.abisiniya.com/api/v1/vehicle/auth/list"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      // print(res.body);
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

  void bookVehicle(BuildContext context, String start_date, String end_date,
      int vehicle_id) async {
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
            "https://staging.abisiniya.com/api/v1/booking/vehicle/booking/authuser",
          ),
          body: {
            "start_date": start_date.split(" ")[0],
            "end_date": end_date.split(" ")[0],
            "bookable_type": "Vehicle",
            "bookable_id": vehicle_id.toString(),
          });

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

  Future<void> addVehicles(
    BuildContext context,
    String name,
    String address,
    String city,
    String country,
    String make,
    String model,
    int year,
    int engineSize,
    String fuelType,
    int weight,
    String color,
    String transmission,
    int price,
    List<File> images,
  ) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      var uri = Uri.parse("https://staging.abisiniya.com/api/v1/vehicle/add");
      var request = http.MultipartRequest('POST', uri)
        ..fields['name'] = name
        ..fields['address'] = address
        ..fields['city'] = city
        ..fields['country'] = country
        ..fields['make'] = make
        ..fields['model'] = model
        ..fields['year'] = year.toString()
        ..fields['engine_size'] = engineSize.toString()
        ..fields['fuel_type'] = fuelType
        ..fields['weight'] = weight.toString()
        ..fields['color'] = color
        ..fields['transmission'] = transmission
        ..fields['price'] = price.toString();

      for (var image in images) {
        var multipartFile = await http.MultipartFile.fromPath(
          'pictures[]',
          image.path,
          filename: basename(image.path),
        );
        request.files.add(multipartFile);
      }

      request.headers['Authorization'] = 'Bearer ${user.user.token}';
      print(user.user.token);

      var res = await request.send();

      var response = await http.Response.fromStream(res);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehicle Added Successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add vehicle: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: ${e.toString()}')),
      );
    }
  }

  void deleteApartment(BuildContext context, int id) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.delete(
        Uri.parse("https://staging.abisiniya.com/api/v1/vehicle/delete/$id"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      print(res.statusCode);
      httpErrorHandle(
        response: res,
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
        onSuccess: () {
          showSnackBar(context, "Apartment Deleted Successfully");
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }

  Future<void> updateVehicle(
    BuildContext context,
    String name,
    String address,
    String city,
    String country,
    String make,
    String model,
    int year,
    int engineSize,
    String fuelType,
    int weight,
    String color,
    String transmission,
    int price,
    int id,
  ) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      final updatedData = {
        'name': name,
        'address': address,
        'city': city,
        'country': country,
        'make': make,
        'model': model,
        'year': year,
        'engine_size': engineSize,
        'fuel_type': fuelType,
        'weight': weight,
        'color': color,
        'transmission': transmission,
        'price': price,
        'status': 'pending', // Assuming status is needed
      };

      final uri = Uri.parse(
        "https://staging.abisiniya.com/api/v1/vehicle/update/$id",
      );

      final res = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.user.token}',
        },
        body: jsonEncode(updatedData),
      );

      httpErrorHandle(
        response: res,
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
        onSuccess: () {
          showSnackBar(context, "Vehicle Updated Successfully");
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }
}

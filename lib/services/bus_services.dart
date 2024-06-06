import 'dart:convert';
import 'dart:io';
import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/bus.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class BusServices {
  Future<List<Bus>> getAllBuses(BuildContext context) async {
    try {
      http.Response res = await http.get(
          Uri.parse(
            "https://staging.abisiniya.com/api/v1/bus/list",
          ),
          headers: {
            'Accept': 'application/json',
          });
      List<Bus> fetchedBus = [];
      // print(fetchedApartments);
      httpErrorHandle(
        response: res,
        onSuccess: () {
          var data = jsonDecode(jsonEncode(jsonDecode(res.body)['data']));
          // print(jsonDecode(res.body)['data'][0]['model']);
          for (var i = 0; i < data.length; i++) {
            Bus bus = Bus(
              name: jsonDecode(res.body)['data'][i]['name'].toString(),
              seater: jsonDecode(res.body)['data'][i]['seater'],
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
            fetchedBus.add(bus);
          }
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );

      return fetchedBus;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
      return [];
    }
  }

  Future<List<dynamic>?> usersBus(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("https://staging.abisiniya.com/api/v1/bus/auth/list"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      print(user.user.token);
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

  Future<bool> addBus(
    BuildContext context,
    String name,
    int seater,
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
      var uri = Uri.parse("https://staging.abisiniya.com/api/v1/bus/add");
      var request = http.MultipartRequest('POST', uri)
        ..fields['name'] = name
        ..fields['seater'] = seater.toString()
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
      request.headers['Accept'] = 'application/json';
      print(user.user.token);

      var res = await request.send();

      var response = await http.Response.fromStream(res);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        return true;
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Vehicle Added Successfully')),
        // );
      } else {
        return false;
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to add vehicle: ${response.body}')),
        // );
      }
    } catch (e) {
      return false;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error occurred: ${e.toString()}')),
      // );
    }
  }

  Future<bool> updateBus(
    BuildContext context,
    String name,
    int seater,
    String address,
    String city,
    String country,
    String make,
    String model,
    String status,
    int year,
    int engineSize,
    String fuelType,
    int weight,
    String color,
    String transmission,
    int price,
    String id,
  ) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      final updatedData = {
        'name': name,
        'seater': seater.toString(),
        'address': address,
        'city': city,
        'country': country,
        'make': make,
        'model': model,
        'year': year.toString(),
        'engine_size': engineSize.toString(),
        'fuel_type': fuelType,
        'weight': weight.toString(),
        'color': color,
        'transmission': transmission,
        'price': price.toString(),
        'status': status
      };

      final uri = Uri.parse(
        "https://staging.abisiniya.com/api/v1/bus/update/$id",
      );

      final res = await http.put(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${user.user.token}',
        },
        body: updatedData,
      );
      print(res.statusCode);

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
      // httpErrorHandle(
      //   response: res,
      //   onError: (errorMessage) {
      //     showSnackBar(context, errorMessage);
      //   },
      //   onSuccess: () {
      //     showSnackBar(context, "Bus Updated Successfully");
      //     Navigator.of(context).pop();
      //   },
      // );
    } catch (e) {
      return false;
      // final errorMessage = "Error occurred: ${e.toString()}";
      // showSnackBar(context, errorMessage);
    }
  }

  Future<bool> deleteBus(BuildContext context, int id) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.delete(
        Uri.parse("https://staging.abisiniya.com/api/v1/bus/delete/$id"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
      // httpErrorHandle(
      //   response: res,
      //   onError: (errorMessage) {
      //     showSnackBar(context, errorMessage);
      //   },
      //   onSuccess: () {
      //     showSnackBar(context, "Bus Deleted Successfully");
      //   },
      // );
    } catch (e) {
      return false;
      // final errorMessage = "Error occurred: ${e.toString()}";
      // showSnackBar(context, errorMessage);
    }
  }
}

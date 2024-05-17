import 'dart:convert';

import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/provider/user.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ApartmentServices {
  Future<List<Apartment>> getAllApartments(BuildContext context) async {
    try {
      http.Response res = await http
          .get(Uri.parse("https://www.abisiniya.com/api/v1/apartment/list"));
      List<Apartment> fetchedApartments = [];
      final user = Provider.of<UserProvider>(context, listen: false);
      print(user.user.token);
      httpErrorHandle(
        response: res,
        onSuccess: () {
          var data = jsonDecode(jsonEncode(jsonDecode(res.body)['data']));

          for (var i = 0; i < data.length; i++) {
            var pictures = jsonDecode(
                jsonEncode(jsonDecode(res.body)['data'][i]['pictures']));

            List<String> imageUrls = [];

            for (var picture in pictures) {
              imageUrls.add(picture['imageUrl']);
            }

            Apartment apartment = Apartment(
              images: imageUrls,
              text: data[i]['city'],
              address: data[i]['address'],
              location: data[i]['country'],
              guest: data[i]['guest'],
              bathroom: data[i]['bathroom'],
              bedroom: data[i]['bedroom'],
              price: data[i]['price'],
            );
            fetchedApartments.add(apartment);
          }
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );

      return fetchedApartments;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
      return [];
    }
  }

  Future<void> addApartments(
      BuildContext context,
      String name,
      String address,
      String city,
      String country,
      int guest,
      int bedroom,
      int bathroom,
      int price,
      List<String> images) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.post(
        Uri.parse(
            "https://www.abisiniya.com/api/v1/apartment/add?name=$name&address=$address&city=$city&country=$country&guest=$guest&bedroom=$bedroom&bathroom=$bathroom&price=$price"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.user.token}',
        },
      );

      httpErrorHandle(
        response: res,
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
        onSuccess: () {
          showSnackBar(context, "Apartment Added Successfully");
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }

  usersApartment(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("https://www.abisiniya.com/api/v1/apartment/auth/list"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.user.token}',
        },
      );

      print(jsonDecode(res.body)['data']);
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }
}

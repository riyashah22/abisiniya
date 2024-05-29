import 'dart:convert';
import 'dart:io';
import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:path/path.dart';

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
    List<File> images,
  ) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      var uri = Uri.parse("https://staging.abisiniya.com/api/v1/apartment/add");
      var request = http.MultipartRequest('POST', uri)
        ..fields['name'] = name
        ..fields['address'] = address
        ..fields['city'] = city
        ..fields['country'] = country
        ..fields['guest'] = guest.toString()
        ..fields['bedroom'] = bedroom.toString()
        ..fields['bathroom'] = bathroom.toString()
        ..fields['price'] = price.toString();

      for (var image in images) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();

        var multipartFile = http.MultipartFile(
          'pictures',
          stream,
          length,
          filename: basename(image.path),
        );
        request.files.add(multipartFile);
      }

      request.headers['Authorization'] = 'Bearer ${user.user.token}';
      print(request.headers);
      var res = await request.send();

      var response = await http.Response.fromStream(res);
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apartment Added Successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add apartment: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: ${e.toString()}')),
      );
    }
  }

  Future<List<dynamic>?> usersApartment(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("https://www.abisiniya.com/api/v1/apartment/auth/list"),
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

  void deleteApartment(BuildContext context, int id) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.delete(
        Uri.parse("https://www.abisiniya.com/api/v1/apartment/delete/$id"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
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

  Future<void> updateApartments(
      BuildContext context,
      String name,
      String address,
      String city,
      String country,
      int guest,
      int bedroom,
      int bathroom,
      int price,
      int id) async {
    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.post(
        Uri.parse(
            "https://www.abisiniya.com/api/v1/apartment/update/$id?name=$name&address=$address&city=$city&country=$country&guest=$guest&bedroom=$bedroom&bathroom=$bathroom&price=$price&property_type_id=null&status=pending"),
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
          showSnackBar(context, "Apartment Updated Successfully");
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }
}

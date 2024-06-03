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
      http.Response res = await http.get(
          Uri.parse("https://staging.abisiniya.com/api/v1/apartment/list"));
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
              id: data[i]['id'],
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
          showErrorMessage(context, "Apartment Not Added. Try Again!!");
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
        var multipartFile = await http.MultipartFile.fromPath(
          'pictures[]',
          image.path,
          filename: basename(image.path),
        );
        request.files.add(multipartFile);
      }

      request.headers['Authorization'] = 'Bearer ${user.user.token}';

      var res = await request.send();

      var response = await http.Response.fromStream(res);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        showSuccessMessage(context, "Apartment Added Successfully");
      } else {
        showErrorMessage(context, "Failed to add Apartment. Try Again!!");
      }
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
  }

  Future<List<dynamic>?> usersApartment(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("https://staging.abisiniya.com/api/v1/apartment/auth/list"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['data'];
      } else {
        showErrorMessage(context, 'Failed to load apartments');
      }
    } catch (e) {
      showErrorMessage(context, "Error 404");
    }
    return null;
  }

  void deleteApartment(BuildContext context, int id) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.delete(
        Uri.parse("https://staging.abisiniya.com/api/v1/apartment/delete/$id"),
        headers: {
          'Authorization': 'Bearer ${user.user.token}',
        },
      );
      httpErrorHandle(
        response: res,
        onError: (errorMessage) {
          showErrorMessage(context, "Failed to delete Apartment");
        },
        onSuccess: () {
          showSuccessMessage(context, "Apartment Deleted Successfully");
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
    String status,
    int guest,
    int bedroom,
    int bathroom,
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
        'guest': guest,
        'bedroom': bedroom,
        'bathroom': bathroom,
        'price': price,
        'property_type_id': null,
        'status': status,
      };

      final uri = Uri.parse(
        "https://staging.abisiniya.com/api/v1/apartment/update/$id",
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
          showErrorMessage(context, "Failed to update Apartment");
        },
        onSuccess: () {
          showSuccessMessage(context, "Apartment Updated Successfully");
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showErrorMessage(context, errorMessage);
    }
  }

  Future<List<Apartment>> searchApartment(
      BuildContext context, String search) async {
    try {
      List<Apartment> fetchedApartments = [];
      final res = await http.post(
        Uri.parse(
            "https://staging.abisiniya.com/api/v1/common/search?type=apartment&keyword=$search"),
      );

      httpErrorHandle(
        response: res,
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
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
      );
      return fetchedApartments;
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
    return [];
  }

  void bookApartment(BuildContext context, String start_date, String end_date,
      int apartment_id) async {
    void handleHttpError(String errorMessage) {
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
            "bookable_type": "Apartment",
            "bookable_id": apartment_id.toString(),
          });

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          showSuccessMessage(context, "Apartment booked Successfully ");
        },
        onError: (errorMessage) {
          // showSnackBar(context, errorMessage); //new comment
          showErrorMessage(context, "Failed to booked an Apartment");
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}

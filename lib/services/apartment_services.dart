import 'dart:convert';

import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/apartment.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApartmentServices {
  Future<List<Apartment>> getAllApartments(BuildContext context) async {
    try {
      http.Response res = await http
          .get(Uri.parse("https://www.abisiniya.com/api/v1/apartment/list"));
      List<Apartment> fetchedApartments = [];
      // print(fetchedApartments);
      httpErrorHandle(
        response: res,
        onSuccess: () {
          var data = jsonDecode(jsonEncode(jsonDecode(res.body)['data']));

          for (var i = 0; i < data.length; i++) {
            var j = jsonDecode(
                jsonEncode(jsonDecode(res.body)['data'][i]['pictures']));
            Apartment apartment = Apartment(
              image: jsonDecode(
                  jsonEncode(jsonDecode(jsonEncode(j))[0]['imageUrl'])),
              text: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['city'])),
              address: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['address'])),
              location: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['country'])),
              guest: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['guest'])),
              bathroom: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['bathroom'])),
              bedroom: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['bedroom'])),
              price: jsonDecode(
                  jsonEncode(jsonDecode(res.body)['data'][i]['price'])),
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
}

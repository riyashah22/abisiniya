import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required void Function(String) onError,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 404:
      onError(jsonDecode(response.body)['message']);
      break;
    case 400:
      onError(jsonDecode(response.body)['message']['email'][0]);
      break;
    case 500:
      onError(jsonDecode(response.body)['message']);
      break;
    default:
      onError(response.body);
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void showErrorMessage(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

void showSuccessMessage(BuildContext context, String successMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Success"),
        content: Text(successMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

void showBookingSuccessfulDialog(BuildContext context, String path) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                path, // Replace with your GIF asset path
                height: 120,
                width: 120,
              ),
              SizedBox(height: 16),
              Text(
                "Booking Successful",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';

class BookingDetails extends StatefulWidget {
  static const String routeName = "booking-Details";
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  AuthServices authServices = AuthServices();
  List<dynamic> myBookings = [];
  Future<void> myDetailBookingsList() async {
    final bookingList = await authServices.userDetailBookings(context);
    setState(() {
      myBookings = bookingList ?? [];
    });
    print(myBookings[0]['name']);
  }

  @override
  void initState() {
    myDetailBookingsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarSecondaryScreen(context, "Booking Details"),
        body: Container(
            child: Column(
          children: [OwnerCard("Riya", "riya@gmail.com")],
        )));
  }

  Widget OwnerCard(String name, String email) {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Owner Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  email,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:abisiniya/screens/dashboard/detailBookings.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<dynamic> myBookings = [];
  AuthServices authServices = AuthServices();

  Future<void> myBookingsList() async {
    final bookingList = await authServices.userBookings(context);
    setState(() {
      myBookings = bookingList ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    myBookingsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My Bookings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            itemCount: myBookings.length,
            itemBuilder: (context, index) {
              return CardItem(booking: myBookings[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget CardItem({required dynamic booking}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(bottom: 10),
      child: Card(
        color: CustomColors.lightPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Type: ${booking["type"]}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RichTextCustom("Reference", booking["reference"])
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextCustom("CheckIn", booking['checkIn']),
                  RichTextCustom(
                    "CheckOut",
                    booking['checkOut'],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichTextCustom(
                    "Payment Status",
                    booking['paymentStatus'],
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextCustom(
                      "Booking Date", "${booking['date'].split(" ")[0]}"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        BookingDetails.routeName,
                        arguments: {
                          'id': booking['id'],
                          'type': booking['type']
                        },
                      );
                      print(booking['id']);
                    },
                    child: Text('View'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget RichTextCustom(String label, String value) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

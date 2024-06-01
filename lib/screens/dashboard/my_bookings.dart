import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  // Sample data for bookings
  List<dynamic> myBookings = [];
  AuthServices authServices = AuthServices();

  Future<void> myBookingsList() async {
    final bookingList = await authServices.userBookings(context);
    setState(() {
      myBookings = bookingList!;
    });
    print(myBookings);
  }

  String? selectedBooking;

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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FixedColumnWidth(100.0),
                1: FixedColumnWidth(150.0),
                2: FixedColumnWidth(150.0),
                3: FixedColumnWidth(100.0),
                4: FixedColumnWidth(100.0),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Type',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Check In',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Check Out',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Payment Status',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Booking ID',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                for (var booking in myBookings)
                  TableRow(
                    decoration: BoxDecoration(
                      color: booking == selectedBooking
                          ? Colors.blue[100]
                          : Colors.white,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBooking = booking;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(booking['country'].toString()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(booking['name']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(booking['email']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(booking['phone'].toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(booking[0]['address'].toString()),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

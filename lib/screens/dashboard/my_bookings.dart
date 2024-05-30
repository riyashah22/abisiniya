import 'package:flutter/material.dart';


class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  // Sample data for bookings
  final List<String> myBookings = [
    'Booking 1',
    'Booking 2',
    'Booking 3',
  ];

  String? selectedBooking;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Text(
                'My Bookings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: myBookings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(myBookings[index]),
                      onTap: () {
                        setState(() {
                          selectedBooking = myBookings[index];
                        });
                      },
                      selected: myBookings[index] == selectedBooking,
                    );
                  },
                ),
              ),
      ],
    );
  }
}
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
  }

  String? selectedBooking;


  @override
  void initState() {
    super.initState();
    myBookingsList();
  }
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
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: myBookings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("myBookings[index]"),
                      onTap: () {
                        // setState(() {
                        //   selectedBooking = myBookings[index];
                        // });
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
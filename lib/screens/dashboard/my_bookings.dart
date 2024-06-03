import 'package:abisiniya/screens/dashboard/detailBookings.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        booking['type'] == "Vehicle"
                            ? "assets/car.png"
                            : "assets/apartments.png",
                        height: 36,
                        width: 36,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        ' ${booking["type"]}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xffFF5800).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Reference: ",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xffFF5800),
                          ),
                        ),
                        Text(
                          booking['reference'],
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xffFF5800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Check-in",
                          style: GoogleFonts.roboto(
                            color: Color(0xff708090),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          booking['checkIn'],
                          style: GoogleFonts.openSans(
                            color: CustomColors.smokyBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/arrows.png",
                    height: 36,
                    width: 36,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Check-out",
                          style: GoogleFonts.roboto(
                            color: Color(0xff708090),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          booking['checkOut'],
                          style: GoogleFonts.openSans(
                            color: CustomColors.smokyBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Payment Status: ",
                          style: GoogleFonts.roboto(
                            color: CustomColors.smokyBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: booking['paymentStatus'],
                          style: GoogleFonts.openSans(
                            color: booking['paymentStatus'] == "Not Paid"
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booked on: ${booking['date'].toString().split(" ")[0]}",
                    style: GoogleFonts.roboto(
                      color: Colors.grey.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // RichTextCustom(
                  //     "Booking Date", "${booking['date'].split(" ")[0]}"),
                  TextButton(
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
                    child: Text('Details'),
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

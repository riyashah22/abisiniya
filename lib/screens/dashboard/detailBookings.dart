import 'package:abisiniya/main.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetails extends StatefulWidget {
  static const String routeName = "booking-Details";

  const BookingDetails({Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  AuthServices authServices = AuthServices();
  List<dynamic> myBookings = [];
  String type = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myDetailBookingsList();
    });
  }

  Future<void> myDetailBookingsList() async {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String id = arguments['id'].toString();
    String typeNew = arguments['type'];
    final bookingList =
        await authServices.userDetailBookings(context, id.toString());
    setState(() {
      myBookings = bookingList ?? [];
      type = typeNew;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbarSecondaryScreen(context, "Booking Details"),
        body: myBookings.isNotEmpty
            ? ApartmentDetails()
            : Center(
                child: Image.asset(
                  'assets/loading.gif',
                  width: 100,
                  height: 100,
                ),
              ));
  }

  Widget ApartmentDetails() {
    print(type);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            type == 'Apartment'
                ? OwnerCard(
                    myBookings[0]['name'] == null
                        ? "Unknown"
                        : myBookings[0]['name'],
                    myBookings[0]['email'] == null
                        ? "Unknown"
                        : myBookings[0]['email'],
                    myBookings[0]['phone'] == null
                        ? "Unknown"
                        : myBookings[0]['phone'].toString(),
                    myBookings[0]['address'],
                    myBookings[0]['city'],
                    myBookings[0]['country'],
                  )
                : SizedBox(),
            SizedBox(height: 40),
            type == 'Apartment'
                ? ApartmentCard(
                    myBookings[3].toString(),
                    myBookings[4].toString(),
                  )
                : VehicleCard(
                    myBookings[0]['name'],
                    myBookings[0]['address'],
                    myBookings[0]['city'],
                    myBookings[0]['country'],
                    myBookings[0]['make'],
                    myBookings[0]['model'],
                    myBookings[0]['year'].toString(),
                    myBookings[0]['fuel_type'],
                    myBookings[0]['color'],
                    myBookings[0]['price'].toString(),
                    myBookings[3].toString(),
                    myBookings[4].toString(),
                  ),
            SizedBox(height: 40),
            PaymentStatusCard(
              myBookings[3].toString(),
              myBookings[4].toString(),
              myBookings[1].toString(),
              myBookings[2].toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget OwnerCard(
    String name,
    String email,
    String phone,
    String address,
    String city,
    String country,
  ) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 380,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColors.primaryColor, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24), // Space for the circle to overlap
                Text(
                  'Owner Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                labelData("Name:", name),
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
                    Expanded(
                      child: Text(
                        email,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                labelData('Phone:', phone.toString()),
                Row(
                  children: [
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                            fontSize: 16, overflow: TextOverflow.visible),
                      ),
                    ),
                  ],
                ),
                labelData('City:', city),
                labelData('Country:', country),
              ],
            ),
          ),
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ApartmentCard(
    String checkIn,
    String checkOut,
  ) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 380,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColors.primaryColor, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24), // Space for the circle to overlap
                Text(
                  'Apartment Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                labelData("CheckIn:", checkIn),
                labelData("CheckOut:", checkOut),
              ],
            ),
          ),
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget VehicleCard(
      String name,
      String address,
      String city,
      String country,
      String make,
      String model,
      String year,
      String fuel_type,
      String color,
      String price,
      String checkIn,
      String checkOut) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 380,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColors.primaryColor, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24), // Space for the circle to overlap
                Text(
                  'Vehicle Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                labelData("Name:", name),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                            fontSize: 16, overflow: TextOverflow.visible),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  height: 3,
                ),
                SizedBox(
                  height: 4,
                ),
                labelData("City:", city),
                labelData("Country:", country),
                // labelData("CheckIn:", checkIn),
                // labelData("CheckOut:", checkOut),
                labelData("Make:", make),
                labelData("Model:", model),
                labelData("Year:", year),
                labelData("Fuel Type:", fuel_type),
                labelData("Color:", color),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Price:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '\$${price}',
                        style: TextStyle(
                            fontSize: 16, overflow: TextOverflow.visible),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Image.asset(
                    'assets/car.png',
                    height: 50,
                    width: 50,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget labelData(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Divider(
          height: 2,
        ),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Widget PaymentStatusCard(
      String checkIn, String checkout, String status, String price) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 380,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: CustomColors.primaryColor, width: 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            checkIn,
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
                            checkout,
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
                      color: status == "Not Paid"
                          ? Colors.red.withOpacity(0.9)
                          : Colors.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: status == 'Not Paid'
                                ? "Amount to be paid: \$${price}"
                                : "Amount paid: \$${price}",
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

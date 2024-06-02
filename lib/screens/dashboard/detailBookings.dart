import 'package:abisiniya/main.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  )
                : SizedBox(),
            SizedBox(height: 40),
            type == 'Apartment'
                ? ApartmentCard(
                    myBookings[0]['address'],
                    myBookings[0]['city'],
                    myBookings[0]['country'],
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
              myBookings[1].toString(),
              myBookings[2].toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget OwnerCard(String name, String email, String phone) {
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
                labelData("Name", name),
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
                labelData('phone', phone.toString()),
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
    String address,
    String city,
    String country,
    String checkIn,
    String checkOut,
  ) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 350,
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
                labelData('City', city),
                labelData('Country', country),
                labelData("CheckIn", checkIn),
                labelData("CheckOut", checkOut),
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
            width: 350,
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
                  'Vehicle Details',
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
                labelData("City:", city),
                labelData("Country:", country),
                labelData("CheckIn:", checkIn),
                labelData("CheckOut:", checkOut),
                labelData("Make:", make),
                labelData("Model:", model),
                labelData("Year:", year),
                labelData("Fuel Type:", fuel_type),
                labelData("Color:", color),
                labelData("Price:", price),
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
                  Icons.car_rental,
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

  Widget labelData(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget PaymentStatusCard(String status, String price) {
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
                  'Payment Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      status,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Price:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '\$${price.toString()}',
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.visible,
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

import 'package:abisiniya/screens/dashboard/my_apartments.dart';
import 'package:abisiniya/screens/dashboard/my_bookings.dart';
import 'package:abisiniya/screens/dashboard/my_vehicles.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ApartmentDashboard extends StatefulWidget {
  static const String routeName = '/dashboard-apartment-screen';
  const ApartmentDashboard({Key? key}) : super(key: key);

  @override
  _ApartmentDashboardState createState() => _ApartmentDashboardState();
}

class _ApartmentDashboardState extends State<ApartmentDashboard> {
  // Sample data for bookings
  final List<String> myBookings = [
    'Booking 1',
    'Booking 2',
    'Booking 3',
  ];

  List<dynamic> myApartments = [];
  List<dynamic> myVehicles = [];

  // Variables to store selected items and menu option
  String? selectedBooking;
  String? selectedApartment;
  String selectedMenu = 'My Bookings';

  @override
  void initState() {
    super.initState();
  }

  // ApartmentServices apartmentServices = ApartmentServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarSecondaryScreen(context, "Dashboard"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, // Lighter shadow color
                      blurRadius: 4, // Slightly reduced blur radius
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedMenu,
                      items: ['My Bookings', 'My Apartments', 'My vehicles']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMenu = newValue!;
                          selectedBooking = null;
                          selectedApartment = null;
                        });
                      },
                      dropdownColor: Colors.white,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (selectedMenu == 'My Bookings') ...[
                MyBookings()
              ] else if (selectedMenu == 'My Apartments') ...[
                MyApartments()
              ] else if (selectedMenu == 'My vehicles') ...[
                MyVehicles()
              ],
            ],
          ),
        ));
  }
}

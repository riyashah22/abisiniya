import 'package:abisiniya/screens/dashboard/my_apartments.dart';
import 'package:abisiniya/screens/dashboard/my_vehicles.dart';
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
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedMenu,
              items: ['My Bookings', 'My Apartments', "My vehicles"]
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
            ),
            const SizedBox(height: 20),
            if (selectedMenu == 'My Bookings') ...[
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
            ] else if (selectedMenu == 'My Apartments') ...[
              MyApartments()
            ] else if (selectedMenu == "My vehicles") ...[
              MyVehicles()
            ],
          ],
        ),
      ),
    );
  }
}

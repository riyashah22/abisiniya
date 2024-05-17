import 'package:abisiniya/screens/apartments/add_apartment.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:flutter/material.dart';

class ApartmentDashboard extends StatefulWidget {
  static const String routeName = '/dashboard-apartment-screen';
  const ApartmentDashboard({Key? key}) : super(key: key);

  @override
  _ApartmentDashboardState createState() => _ApartmentDashboardState();
}

class _ApartmentDashboardState extends State<ApartmentDashboard> {
  // Sample data for bookings and apartments
  final List<String> myBookings = [
    'Booking 1',
    'Booking 2',
    'Booking 3',
  ];

  ApartmentServices apartmentServices = ApartmentServices();

  @override
  void initState() {
    print(apartmentServices.getAllApartments(context));
    super.initState();
  }

  final List<String> myApartments = [
    'Apartment 1',
    'Apartment 2',
    'Apartment 3',
  ];

  // Variables to store selected items and menu option
  String? selectedBooking;
  String? selectedApartment;
  String selectedMenu = 'My Bookings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apartment Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedMenu,
              items: ['My Bookings', 'My Apartments'].map((String value) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Apartments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Add Apartment form or show the form in a dialog
                      Navigator.of(context)
                          .pushReplacementNamed(AddApartmentForm.routeName);
                    },
                    child: const Text('Add Apartment'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: myApartments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(myApartments[index]),
                      onTap: () {
                        setState(() {
                          selectedApartment = myApartments[index];
                        });
                      },
                      selected: myApartments[index] == selectedApartment,
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

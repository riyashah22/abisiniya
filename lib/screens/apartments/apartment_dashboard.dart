import 'package:flutter/material.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:abisiniya/screens/apartments/add_apartment.dart';

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

  // Variables to store selected items and menu option
  String? selectedBooking;
  String? selectedApartment;
  String selectedMenu = 'My Bookings';

  @override
  void initState() {
    super.initState();
    fetchUserApartments();
  }

  ApartmentServices apartmentServices = ApartmentServices();

  Future<void> fetchUserApartments() async {
    final apartments = await apartmentServices.usersApartment(context);
    if (apartments != null) {
      setState(() {
        myApartments = apartments;
      });
    }
  }

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
                    var apartment = myApartments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: apartment['pictures'].isNotEmpty
                            ? Image.network(apartment['pictures'][0]['url'],
                                width: 50, height: 50, fit: BoxFit.cover)
                            : Icon(Icons.image, size: 50),
                        title: Text(apartment['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address: ${apartment['address']}'),
                            Text('City: ${apartment['city']}'),
                            Text('Country: ${apartment['country']}'),
                            Text('Bedrooms: ${apartment['bedroom']}'),
                            Text('Bathrooms: ${apartment['bathroom']}'),
                            Text('Price: ${apartment['price']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Implement update functionality
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Implement delete functionality
                              },
                            ),
                          ],
                        ),
                      ),
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

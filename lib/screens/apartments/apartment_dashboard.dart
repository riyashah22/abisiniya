import 'package:abisiniya/screens/vehicles/add_vehicle.dart';
import 'package:abisiniya/services/vehicle_services.dart';
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
  List<dynamic> myVehicles = [];

  // Variables to store selected items and menu option
  String? selectedBooking;
  String? selectedApartment;
  String selectedMenu = 'My Bookings';

  @override
  void initState() {
    super.initState();
    fetchUserApartments();
    fetchUserVehicle();
  }

  ApartmentServices apartmentServices = ApartmentServices();
  VehicleServices vehicleServices = VehicleServices();

  Future<void> fetchUserApartments() async {
    final apartments = await apartmentServices.usersApartment(context);
    if (apartments != null) {
      setState(() {
        myApartments = apartments;
      });
    }
  }

  Future<void> fetchUserVehicle() async {
    final vehicles = await vehicleServices.usersVehicles(context);
    if (vehicles != null) {
      // print(vehicles);
      setState(() {
        myVehicles = vehicles;
      });
    }
  }

  void showEditApartmentDialog(Map<String, dynamic> apartment) {
    TextEditingController nameController =
        TextEditingController(text: apartment['name']);
    TextEditingController addressController =
        TextEditingController(text: apartment['address']);
    TextEditingController cityController =
        TextEditingController(text: apartment['city']);
    TextEditingController countryController =
        TextEditingController(text: apartment['country']);
    TextEditingController guestController =
        TextEditingController(text: apartment['guest'].toString());
    TextEditingController bedroomController =
        TextEditingController(text: apartment['bedroom'].toString());
    TextEditingController bathroomController =
        TextEditingController(text: apartment['bathroom'].toString());
    TextEditingController priceController =
        TextEditingController(text: apartment['price'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Apartment'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                TextField(
                  controller: guestController,
                  decoration: const InputDecoration(labelText: 'Guest'),
                ),
                TextField(
                  controller: bedroomController,
                  decoration: const InputDecoration(labelText: 'Bedrooms'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: bathroomController,
                  decoration: const InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call update apartment service here
                apartmentServices.updateApartments(
                    context,
                    nameController.text,
                    addressController.text,
                    cityController.text,
                    countryController.text,
                    int.parse(guestController.text),
                    int.parse(bedroomController.text),
                    int.parse(bathroomController.text),
                    int.parse(priceController.text),
                    apartment['id']);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showEditVehicleDialog(Map<String, dynamic> vehicle) {
    TextEditingController nameController =
        TextEditingController(text: vehicle['name']);
    TextEditingController addressController =
        TextEditingController(text: vehicle['address']);
    TextEditingController cityController =
        TextEditingController(text: vehicle['city']);
    TextEditingController countryController =
        TextEditingController(text: vehicle['country']);
    TextEditingController makeController =
        TextEditingController(text: vehicle['make']);
    TextEditingController modelController =
        TextEditingController(text: vehicle['model']);
    TextEditingController yearController =
        TextEditingController(text: vehicle['year'].toString());
    TextEditingController engineSizeController =
        TextEditingController(text: vehicle['engine_size'].toString());
    TextEditingController fuelTypeController =
        TextEditingController(text: vehicle['fuel_type']);
    TextEditingController weightController =
        TextEditingController(text: vehicle['weight'].toString());
    TextEditingController colorController =
        TextEditingController(text: vehicle['color']);
    TextEditingController transmissionController =
        TextEditingController(text: vehicle['transmission']);
    TextEditingController priceController =
        TextEditingController(text: vehicle['price'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Vehicle'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                TextField(
                  controller: makeController,
                  decoration: const InputDecoration(labelText: 'Make'),
                ),
                TextField(
                  controller: modelController,
                  decoration: const InputDecoration(labelText: 'Model'),
                ),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: engineSizeController,
                  decoration: const InputDecoration(labelText: 'Engine Size'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: fuelTypeController,
                  decoration: const InputDecoration(labelText: 'Fuel Type'),
                ),
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                ),
                TextField(
                  controller: transmissionController,
                  decoration: const InputDecoration(labelText: 'Transmission'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call update vehicle service here
                vehicleServices.updateVehicle(
                  context,
                  nameController.text,
                  addressController.text,
                  cityController.text,
                  countryController.text,
                  makeController.text,
                  modelController.text,
                  int.parse(yearController.text),
                  int.parse(engineSizeController.text),
                  fuelTypeController.text,
                  int.parse(weightController.text),
                  colorController.text,
                  transmissionController.text,
                  int.parse(priceController.text),
                  vehicle['id'],
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                    // print(apartment);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: apartment['pictures'].isNotEmpty
                            ? Image.network(
                                apartment['pictures'][0]['imageUrl'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover)
                            : const Icon(Icons.image, size: 50),
                        title: Text(apartment['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address: ${apartment['address']}'),
                            Text('City: ${apartment['city']}'),
                            Text('Country: ${apartment['country']}'),
                            Text('Guest: ${apartment['guest']}'),
                            Text('Bedrooms: ${apartment['bedroom']}'),
                            Text('Bathrooms: ${apartment['bathroom']}'),
                            Text('Price: \$${apartment['price']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showEditApartmentDialog(apartment);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                apartmentServices.deleteApartment(
                                    context, apartment['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else if (selectedMenu == "My vehicles") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Vehicles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AddVehicleScreen.routeName);
                    },
                    child: const Text('Add Vehicle'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: myVehicles.length,
                  itemBuilder: (context, index) {
                    var vehicle = myVehicles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: vehicle['pictures'].isNotEmpty
                            ? Image.network(vehicle['pictures'][0]['imageUrl'],
                                width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image, size: 50),
                        title: Text(vehicle['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address: ${vehicle['address']}'),
                            Text('City: ${vehicle['city']}'),
                            Text('Country: ${vehicle['country']}'),
                            Text('Engine Size: ${vehicle['engine_size']}'),
                            Text('Fuel Type: ${vehicle['fuel_type']}'),
                            Text('Makex: ${vehicle['make']}'),
                            Text('Weight: ${vehicle['weight']}'),
                            Text('Transmission: ${vehicle['transmission']}'),
                            Text('Price: \$${vehicle['price']}'),
                            Text('Status: ${vehicle['status']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showEditVehicleDialog(vehicle);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                vehicleServices.deleteApartment(
                                    context, vehicle['id']);
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

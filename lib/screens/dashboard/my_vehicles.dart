import 'package:abisiniya/screens/vehicles/add_vehicle.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:flutter/material.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({super.key});

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {

  VehicleServices vehicleServices = VehicleServices();

  
  List<dynamic> myVehicles = [];

  Future<void> fetchUserVehicle() async {
    final vehicles = await vehicleServices.usersVehicles(context);
    if (vehicles != null) {
      // print(vehicles);
      setState(() {
        myVehicles = vehicles;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserVehicle();
    // TODO: implement initState
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
    return Column(
      children: [
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
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
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
    );
  }
}
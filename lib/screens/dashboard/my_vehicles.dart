import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/screens/vehicles/add_vehicle.dart';
import 'package:abisiniya/screens/vehicles/view_vehicle.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({super.key});

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  VehicleServices vehicleServices = VehicleServices();

  List<dynamic> myVehicles = [];
  bool isLoading = false;

  Future<void> fetchUserVehicle() async {
    setState(() {
      isLoading = true;
    });
    final vehicles = await vehicleServices.usersVehicles(context);
    if (vehicles != null) {
      setState(() {
        myVehicles = vehicles;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserVehicle();
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
    String selectedStatus = 'Pending';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(child: const Text('Update Vehicle')),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      value: selectedStatus,
                      items: [
                        DropdownMenuItem(
                          child: Text("Pending"),
                          value: "Pending",
                        ),
                        DropdownMenuItem(
                          child: Text("Inactive"),
                          value: "Inactive",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                    )
                  ],
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
              style: ButtonStyle(
                foregroundColor:
                    WidgetStatePropertyAll(CustomColors.lightPrimaryColor),
                backgroundColor:
                    WidgetStatePropertyAll(CustomColors.primaryColor),
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 16),
                          Text("Updating Vehicle"),
                        ],
                      ),
                    );
                  },
                );
                var result = await vehicleServices.updateVehicle(
                  context,
                  nameController.text,
                  addressController.text,
                  cityController.text,
                  countryController.text,
                  makeController.text,
                  modelController.text,
                  selectedStatus,
                  int.parse(yearController.text),
                  int.parse(engineSizeController.text),
                  fuelTypeController.text,
                  int.parse(weightController.text),
                  colorController.text,
                  transmissionController.text,
                  int.parse(priceController.text),
                  vehicle['id'],
                );

                Navigator.pop(context);
                if (result) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text(
                            "Vehicle Updated Successfully.\nPlease Refresh the screen to view changes."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showErrorMessage(context, "Failed to update vehicle.");
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pushNamed(AddVehicleScreen.routeName);
              },
              child: Text(
                'Add Vehicle',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isLoading)
          Container(
            height: height * 0.6,
            child: Center(
              child: Center(
                child: Image.asset(
                  "assets/loading.gif",
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          )
        else if (myVehicles.isEmpty)
          Container(
            height: height * 0.6,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.2,
                  ),
                  Image.asset("assets/noDataFound.gif"),
                  Text(
                    "No Data Found",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.smokyBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: myVehicles.length,
              itemBuilder: (context, index) {
                var vehicle = myVehicles[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: vehicle['pictures'].isNotEmpty
                      ? Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  vehicle['pictures'][0]['imageUrl'],
                                  height: 300,
                                  fit: BoxFit.cover,
                                  color: Color.fromRGBO(0, 0, 0,
                                      0.5), // Black color with 50% opacity
                                  colorBlendMode: BlendMode.srcOver,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Semi-transparent background
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vehicle['model'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${vehicle['make']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_gas_station,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${vehicle['fuel_type']}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.settings_input_component,
                                              color: Colors.yellowAccent,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              '${vehicle['transmission']}',
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.public,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${vehicle['country']}',
                                              style: TextStyle(
                                                color: Colors.lightBlueAccent,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.price_change_rounded,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              '\$${vehicle['price']}/day',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OutlinedButton.icon(
                                          icon: Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Colors.grey,
                                          ),
                                          label: Text(
                                            "View",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          onPressed: () {
                                            var vehicleX = Vehicle(
                                              name: vehicle['name'].toString(),
                                              address:
                                                  vehicle['address'].toString(),
                                              city: vehicle['city'].toString(),
                                              country:
                                                  vehicle["country"].toString(),
                                              make: vehicle["make"].toString(),
                                              model:
                                                  vehicle["model"].toString(),
                                              year: vehicle["year"],
                                              engineSize: vehicle["engine_size"]
                                                  .toString(),
                                              fuelType: vehicle["fuel_type"]
                                                  .toString(),
                                              weight:
                                                  vehicle["weight"].toString(),
                                              color:
                                                  vehicle["color"].toString(),
                                              transmission:
                                                  vehicle["transmission"]
                                                      .toString(),
                                              price: vehicle["price"],
                                              status:
                                                  vehicle["status"].toString(),
                                              images: vehicle["pictures"][0]
                                                  ['imageUrl'],
                                            );
                                            Navigator.pushNamed(
                                              context,
                                              ViewVehicle.routeName,
                                              arguments: vehicleX,
                                            );
                                          },
                                        ),
                                        OutlinedButton.icon(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          ),
                                          label: Text(
                                            "Edit",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          onPressed: () {
                                            showEditVehicleDialog(vehicle);
                                          },
                                        ),
                                        OutlinedButton.icon(
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.grey,
                                          ),
                                          label: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return const AlertDialog(
                                                  content: Row(
                                                    children: [
                                                      CircularProgressIndicator(),
                                                      SizedBox(width: 16),
                                                      Text(
                                                          "Deleting vehicle..."),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                            var result = await vehicleServices
                                                .deleteVehicle(
                                              context,
                                              vehicle['id'],
                                            );

                                            Navigator.pop(context);

                                            if (result) {
                                              showSuccessMessage(context,
                                                  "Vehicle Deleted Successfully.\nPlease Refresh the screen to view changes.");
                                            } else {
                                              showErrorMessage(context,
                                                  "Something went wrong");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Icon(Icons.image, size: 50),
                );
              },
            ),
          ),
      ],
    );
  }
}

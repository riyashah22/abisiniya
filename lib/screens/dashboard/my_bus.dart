import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abisiniya/screens/vehicles/add_bus.dart';
import 'package:abisiniya/services/bus_services.dart';

class MyBus extends StatefulWidget {
  const MyBus({super.key});

  @override
  State<MyBus> createState() => _MyBusState();
}

class _MyBusState extends State<MyBus> {
  BusServices busServices = BusServices();

  List<dynamic> myBus = [];

  Future<void> fetchUserBus() async {
    final vehicles = await busServices.usersBus(context);
    if (vehicles != null) {
      setState(() {
        myBus = vehicles;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserBus();
  }

  void showEditBusDialog(Map<String, dynamic> vehicle) {
    TextEditingController nameController =
        TextEditingController(text: vehicle['name']);
    TextEditingController seaterController =
        TextEditingController(text: vehicle['seater'].toString());
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
          title: Text('Edit Bus',
              style: GoogleFonts.openSans(color: Colors.black)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: seaterController,
                  decoration: InputDecoration(
                      labelText: 'Seater',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: countryController,
                  decoration: InputDecoration(
                      labelText: 'Country',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: makeController,
                  decoration: InputDecoration(
                      labelText: 'Make',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: modelController,
                  decoration: InputDecoration(
                      labelText: 'Model',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(
                      labelText: 'Year',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: engineSizeController,
                  decoration: InputDecoration(
                      labelText: 'Engine Size',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: fuelTypeController,
                  decoration: InputDecoration(
                      labelText: 'Fuel Type',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                      labelText: 'Weight',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: colorController,
                  decoration: InputDecoration(
                      labelText: 'Color',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: transmissionController,
                  decoration: InputDecoration(
                      labelText: 'Transmission',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: GoogleFonts.openSans(color: Colors.black)),
                  style: GoogleFonts.openSans(color: Colors.black),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Status",
                      style: GoogleFonts.openSans(
                          fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      value: selectedStatus,
                      items: [
                        DropdownMenuItem(
                          child: Text("Pending",
                              style: GoogleFonts.openSans(color: Colors.black)),
                          value: "Pending",
                        ),
                        DropdownMenuItem(
                          child: Text("Inactive",
                              style: GoogleFonts.openSans(color: Colors.black)),
                          value: "Inactive",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
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
              child: Text('Cancel',
                  style: GoogleFonts.openSans(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                busServices.updateBus(
                  context,
                  nameController.text,
                  int.parse(seaterController.text),
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
                  vehicle['id'].toString(),
                );
              },
              child: Text('Save',
                  style: GoogleFonts.openSans(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Buses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddBusScreen.routeName);
              },
              child: Text(
                'Add Bus',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: myBus.length,
            itemBuilder: (context, index) {
              var vehicle = myBus[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.network(
                                vehicle['pictures'][0]['imageUrl'],
                                height: screenWidth * 0.25,
                                width: screenWidth * 0.25,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              Icon(Icons.location_city),
                              const SizedBox(width: 6),
                              Text(
                                vehicle['city'],
                                style:
                                    GoogleFonts.openSans(color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              Icon(Icons.location_on),
                              const SizedBox(width: 6),
                              Text(
                                vehicle['country'],
                                style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          width: 3,
                          height: screenHeight * 0.16,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            buildRow(Icon(Icons.directions_bus_filled_outlined),
                                vehicle['name']),
                            const SizedBox(height: 5),
                            buildRow(Icon(Icons.person_3),
                                '${vehicle['seater']} Seater'),
                            const SizedBox(height: 5),
                            buildRow(Icon(Icons.local_gas_station_sharp),
                                vehicle['fuel_type']),
                            const SizedBox(height: 5),
                            buildRow(
                                Icon(Icons.settings), vehicle['transmission']),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 8.0),
                      child: Column(
                        children: [
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                showEditBusDialog(vehicle);
                              } else if (value == 'delete') {
                                busServices.deleteBus(context, vehicle['id']);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              child: const Icon(
                                Icons.double_arrow_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.12,
                          ),
                          Text(
                            '\$${vehicle['price']}/day',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildRow(Icon icon, String text) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class VehicleDetailScreen extends StatefulWidget {
  static const String routeName = '/vehicle-detail-screen';

  const VehicleDetailScreen({
    super.key,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  VehicleServices vehicleServices = VehicleServices();
  DateTime? fromDate;
  DateTime? toDate;

  void bookVehicle() async {
     vehicleServices.bookVehicle(context, fromDate.toString(), toDate.toString(), 5);
  }

  double calculateTotalAmount(int price) {
    if (fromDate != null && toDate != null) {
      final duration = toDate!.difference(fromDate!);
      final nights = duration.inDays;
      return price * nights.toDouble();
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff3e6837),
        title: Text(
          vehicle.make,
          style: const TextStyle(
            color: Color(0xfff8fbf1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    vehicle.images,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.directions_car, "Model",
                                vehicle.model, context),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                                Icons.build, "Make", vehicle.make, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(Icons.local_gas_station, 'Fuel Type',
                      vehicle.fuelType, context),
                  _buildDetailRow(Icons.engineering, 'Engine Size',
                      vehicle.engineSize, context),
                  _buildDetailRow(Icons.settings_input_component,
                      'Transmission', vehicle.transmission, context),
                  _buildDetailRow(
                      Icons.public, 'Country', vehicle.country, context),
                  _buildDetailRow(
                      Icons.location_on, 'Address', vehicle.address, context),
                  _buildDetailRow(
                      Icons.fitness_center, 'Weight', vehicle.weight, context),
                  _buildDetailRow(Icons.price_change_rounded, 'Price',
                      '${vehicle.price} Per Day', context),
                  _buildDetailRow(Icons.calendar_today, 'Year',
                      vehicle.year.toString(), context),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),

            // Booking Details Form
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'From Date:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      fromDate = selectedDate;
                                      toDate = null; // Reset toDate
                                    });
                                  }
                                },
                                child: Text(
                                  fromDate != null
                                      ? fromDate!.toString().split(' ')[0]
                                      : 'Select Date',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'To Date:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (fromDate == null) {
                                    // Check if 'from' date is selected first
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text("Select 'From' Date"),
                                          content: const Text(
                                              "Please select 'from' date first."),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: fromDate!,
                                      firstDate: fromDate!,
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        toDate = selectedDate;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  toDate != null
                                      ? toDate!.toString().split(' ')[0]
                                      : 'Select Date',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Total Amount: \$${calculateTotalAmount(vehicle.price)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${vehicle.price} / night',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF3E6837))),
                onPressed: () {
                  double totalAmount = calculateTotalAmount(vehicle.price);
                  if (totalAmount <= 0) {
                    // If totalAmount is non-positive, either dates are not selected or invalid
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Select Dates"),
                          content: Text(totalAmount == 0
                              ? "Please select both 'from' and 'to' dates."
                              : "Please select a valid date range."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Proceed with booking
                    if (user.user.token.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Alert"),
                            content: const Text("Please log in first."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      bookVehicle();
                      // Show success dialog and reset dates
                      setState(() {
                        fromDate = null;
                        toDate = null;
                      });
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: const Text("Success"),
                      //       content: const Text("Booked Successfully"),
                      //       actions: <Widget>[
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //           child: const Text("OK"),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    }
                  }
                },
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 20, color: Color(0xfff8fbf1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData iconData, String title, String value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              " - $value",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(
      IconData iconData, String title, String value, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff8fbf1),
            Color(0xfff8fbf1),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFBDBDBD),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: const Color(0xFF3E6837),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

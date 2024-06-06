import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/bus.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class BusDetailScreen extends StatefulWidget {
  static const String routeName = '/bus-detail-screen';

  const BusDetailScreen({
    super.key,
  });

  @override
  State<BusDetailScreen> createState() => _BusDetailScreenState();
}

class _BusDetailScreenState extends State<BusDetailScreen> {
  VehicleServices vehicleServices = VehicleServices();
  DateTime? fromDate;
  DateTime? toDate;

  void bookBus() async {
    vehicleServices.bookVehicle(
      context,
      fromDate.toString(),
      toDate.toString(),
      5,
    );
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
    final bus = ModalRoute.of(context)!.settings.arguments as Bus;
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff3e6837),
        title: Text(
          bus.make,
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
                    bus.images,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(16),
                  //       decoration: BoxDecoration(
                  //         color: Colors.green[50],
                  //         borderRadius: BorderRadius.circular(12),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.3),
                  //             spreadRadius: 2,
                  //             blurRadius: 4,
                  //             offset: const Offset(0, 2),
                  //           ),
                  //         ],
                  //       ),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           _buildInfoRow(Icons.directions_car, "Model",
                  //               bus.model, context),
                  //           const SizedBox(height: 16),
                  //           _buildInfoRow(
                  //               Icons.build, "Make", bus.make, context),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    height: 148,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCard(LineIcons.car, "Model", bus.model),
                        _buildCard(Icons.build, "Make", bus.make),
                        _buildCard(
                          Icons.local_gas_station_rounded,
                          "Fuel",
                          bus.fuelType,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Specifications',
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(Icons.group, 'Seater', bus.seater, context),
                  _buildDetailRow(Icons.engineering, 'Engine Size',
                      bus.engineSize, context),
                  _buildDetailRow(Icons.settings_input_component,
                      'Transmission', bus.transmission, context),
                  _buildDetailRow(
                      Icons.public, 'Country', bus.country, context),
                  _buildDetailRow(
                      Icons.location_on, 'Address', bus.address, context),
                  _buildDetailRow(
                      Icons.fitness_center, 'Weight', bus.weight, context),
                  _buildDetailRow(Icons.price_change_rounded, 'Price',
                      '\$${bus.price} Per Day', context),
                  _buildDetailRow(Icons.calendar_today, 'Year',
                      bus.year.toString(), context),
                ],
              ),
            ),

            // Booking Details Form
            Card(
              elevation: 2,
              color: CustomColors.lightPrimaryColor,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Details',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From Date:',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
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
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                    fontSize: 16,
                                  ),
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
                              Text(
                                'To Date:',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
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
                        'Total Amount: \$${calculateTotalAmount(bus.price)}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          fontSize: 22,
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
                '\$${bus.price} / day',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(CustomColors.primaryColor)),
                onPressed: () {
                  double totalAmount = calculateTotalAmount(bus.price);
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
                      // bookVehicle(bus.id);
                      // Show success dialog and reset dates
                      setState(() {
                        fromDate = null;
                        toDate = null;
                      });

                      showSuccessMessage(context,
                          "Please contact us at info@abisiniya.com to book bus.");
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

  Widget _buildCard(IconData icon, String label, String model) {
    return Container(
      width: 106,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: CustomColors.primaryColor,
            size: 38,
          ),
          Text(
            label,
            style: GoogleFonts.raleway(
              color: CustomColors.smokyBlackColor,
              fontSize: 20,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            model,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: CustomColors.smokyBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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

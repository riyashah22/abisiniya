import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ViewVehicle extends StatefulWidget {
  static const String routeName = '/view-vehicle';
  const ViewVehicle({super.key});

  @override
  State<ViewVehicle> createState() => _ViewVehicleState();
}

class _ViewVehicleState extends State<ViewVehicle> {
  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    // final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
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
                  //               vehicle.model, context),
                  //           const SizedBox(height: 16),
                  //           _buildInfoRow(
                  //               Icons.build, "Make", vehicle.make, context),
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
                        _buildCard(LineIcons.car, "Model", vehicle.model),
                        _buildCard(Icons.build, "Make", vehicle.make),
                        _buildCard(
                          Icons.local_gas_station_rounded,
                          "Fuel",
                          vehicle.fuelType,
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
                      '\$${vehicle.price} Per Day', context),
                  _buildDetailRow(Icons.calendar_today, 'Year',
                      vehicle.year.toString(), context),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors.lightPrimaryColor,
            CustomColors.lightPrimaryColor,
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
            color: CustomColors.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: GoogleFonts.raleway(
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
              strutStyle: StrutStyle(fontSize: 12),
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: CustomColors.smokyBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:abisiniya/models/vehicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VehicleDetailScreen extends StatelessWidget {
  static const String routeName = '/vehicle-detail-screen';

  const VehicleDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
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
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.car_rental),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor, // Background color
                        foregroundColor: Theme.of(context)
                            .scaffoldBackgroundColor, // Text color
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Button border radius
                        ),
                      ),
                      label: const Text(
                        "Book Ride now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.85),
            Theme.of(context).primaryColor.withOpacity(0.85),
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
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
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

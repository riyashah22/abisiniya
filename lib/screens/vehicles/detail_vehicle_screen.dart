import 'package:abisiniya/models/vehicles.dart';
import 'package:flutter/material.dart';

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
        elevation: 0, // Remove app bar shadow
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
                  Text(
                    vehicle.model,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.5, // Add some letter spacing
                      color: Colors.black87, // Adjust color to your preference
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vehicle.make,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors
                          .grey[600], // Adjusted color for a modern appearance
                      fontFamily: 'Montserrat', // Using a modern font
                      letterSpacing: 0.2, // Adding a bit of letter spacing
                      fontStyle:
                          FontStyle.italic, // Adding italic style for variation
                    ),
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
                  _buildDetailRow(
                      Icons.local_gas_station, 'Fuel Type', vehicle.fuelType),
                  _buildDetailRow(
                      Icons.engineering, 'Engine Size', vehicle.engineSize),
                  _buildDetailRow(Icons.settings_input_component,
                      'Transmission', vehicle.transmission),
                  _buildDetailRow(Icons.public, 'Country', vehicle.country),
                  _buildDetailRow(
                      Icons.location_on, 'Address', vehicle.address),
                  _buildDetailRow(
                      Icons.fitness_center, 'Weight', vehicle.weight),
                  _buildDetailRow(
                      Icons.attach_money, 'Price', '\$${vehicle.price}'),
                  _buildDetailRow(
                      Icons.calendar_today, 'Year', vehicle.year.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData iconData, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFA5D6A7)
                .withOpacity(0.85), // Darker green with opacity
            const Color(0xFF66BB6A)
                .withOpacity(0.85) // Darker green with opacity
          ],
        ),
        borderRadius: BorderRadius.circular(6), // Add rounded corners
        border: Border.all(
          color: const Color(0xFFBDBDBD), // Add border for a classic look
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData, // Use the provided icon data
            color: Colors.black.withOpacity(0.5), // Adjust color as needed
          ),
          const SizedBox(width: 8), // Add some spacing between icon and title
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
          const SizedBox(width: 12), // Add some spacing between title and value
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors
                    .black87, // Darken the text color for better readability
              ),
            ),
          ),
        ],
      ),
    );
  }
}

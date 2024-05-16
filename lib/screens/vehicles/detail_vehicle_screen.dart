import 'package:abisiniya/models/vehicles.dart';
import 'package:flutter/material.dart';

class VehicleDetailScreen extends StatefulWidget {
  static const String routeName = '/vehicle-detail-screen';

  const VehicleDetailScreen({
    super.key,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(vehicle.address),
      ),
    );
  }
}

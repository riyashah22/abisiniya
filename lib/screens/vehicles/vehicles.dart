import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/screens/vehicles/vehicle_item.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Vehicle> vehicleList = [];
  VehicleServices vehicleServices = VehicleServices();

  @override
  void initState() {
    super.initState();
    fetchVehicles();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchVehicles() async {
    List<Vehicle> fetchedVehicles =
        await vehicleServices.getAllVehicles(context);
    setState(() {
      vehicleList = fetchedVehicles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Cars'),
              Tab(text: 'Bus'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Content of the first tab (Cars)
                _buildVehicleList(),
                Container(
                  child: const Center(
                    child: Text('Bus Tab Content'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList() {
    if (vehicleList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              "Find your car",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vehicleList.length,
              itemBuilder: (context, index) => VehicleItem(
                vehicle: vehicleList[index],
              ),
            ),
          ),
        ],
      );
    }
  }
}

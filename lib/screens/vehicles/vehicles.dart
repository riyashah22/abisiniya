import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/screens/vehicles/vehicle_item.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VehicleScreen extends StatefulWidget {
  static const String routeName = "/vehicle-screen";
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
      appBar: CustomAppbarSecondaryScreen(context, "Book Vehicle"),
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
      return Center(
        child: Image.asset(
          'assets/loading.gif',
          width: 100,
          height: 100,
        ),
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

import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/screens/vehicles/vehicle_item.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

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
    vehicleList = fetchedVehicles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Cars'),
                Tab(text: 'Bus'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Content of the first tab (Cars)
                  Container(
                    child: Column(
                      children: [
                        Text("data"),
                        Container(
                          height: 550,
                          child: ListView.builder(
                            itemCount: vehicleList.length,
                            itemBuilder: (context, index) => VehicleItem(
                              vehicle: vehicleList[index],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Content of the second tab (Bus)
                  Container(
                    child: Center(
                      child: Text('Bus Tab Content'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

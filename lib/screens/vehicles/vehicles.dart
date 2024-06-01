import 'package:abisiniya/models/bus.dart';
import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/screens/vehicles/bus_item.dart';
import 'package:abisiniya/screens/vehicles/vehicle_item.dart';
import 'package:abisiniya/services/vehicle_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class VehicleScreen extends StatefulWidget {
  static const String routeName = "/vehicle-screen";
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController keywordController = TextEditingController();
  TextEditingController searchControllerCar = TextEditingController();

  List<Vehicle> vehicleList = [];
  List<Bus> busList = [];
  VehicleServices vehicleServices = VehicleServices();

  @override
  void initState() {
    super.initState();
    fetchBuses();
    fetchVehicles();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    keywordController.dispose();
    searchControllerCar.dispose();
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

  Future<void> fetchBuses() async {
    List<Bus> fetchedBus = await vehicleServices.getAllBuses(context);
    setState(() {
      busList = fetchedBus;
    });
  }

  void onSearchCar() async {
    // Add your search logic here
    String search = searchControllerCar.text;
    if (search.isNotEmpty) {
      List<Vehicle> searchedVehicles =
          await vehicleServices.searchCar(context, search);
      setState(() {
        vehicleList = searchedVehicles;
      });
    } else {
      fetchVehicles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarSecondaryScreen(context, "Book Vehicle"),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            labelStyle: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: const [
              Tab(
                text: 'Cars',
                icon: Icon(LineIcons.car),
              ),
              Tab(
                text: 'Bus',
                icon: Icon(LineIcons.bus),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Content of the first tab (Cars)
                _carScreen(),
                _BusScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _carScreen() {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Rent a Car ",
                        style: GoogleFonts.roboto(
                          color: CustomColors.smokyBlackColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: "Anytime",
                        style: GoogleFonts.roboto(
                          color: CustomColors.smokyBlackColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Anywhere",
                  style: GoogleFonts.roboto(
                    color: CustomColors.smokyBlackColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          // search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchControllerCar,
                    decoration: InputDecoration(
                      hintText: 'Search cars...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onSearchCar,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
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

  Widget _BusScreen() {
    if (busList.isEmpty) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Rent a Bus ",
                        style: GoogleFonts.roboto(
                          color: CustomColors.smokyBlackColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: "Anytime",
                        style: GoogleFonts.roboto(
                          color: CustomColors.smokyBlackColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Anywhere",
                  style: GoogleFonts.roboto(
                    color: CustomColors.smokyBlackColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: busList.length,
              itemBuilder: (context, index) => BusItem(
                bus: busList[index],
              ),
            ),
          ),
        ],
      );
    }
  }
}

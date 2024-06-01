import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/apartments/detail_apartment_screen.dart';
import 'package:abisiniya/screens/vehicles/detail_vehicle_screen.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/widgets/user_info.dart';
import 'package:abisiniya/screens/apartments/apartments.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/screens/flights/flights.dart';
import 'package:abisiniya/screens/vehicles/vehicles.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:provider/provider.dart';
import 'package:abisiniya/models/vehicles.dart';
import 'package:abisiniya/services/vehicle_services.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screens";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServices authServices = AuthServices();
  ApartmentServices apartmentServices = ApartmentServices();
  VehicleServices vehicleServices = VehicleServices();

  void logoutAction(BuildContext context, String token) {
    authServices.logout(context, token);
  }

  double _scale = 1.0;
  Duration _duration = Duration(milliseconds: 200);

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.9;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    final apartments = await apartmentServices.getAllApartments(context);
    final vehicles = await vehicleServices.getAllVehicles(context);
    return {
      'apartments': apartments,
      'vehicles': vehicles,
    };
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    // Sample airline images, replace with your actual image URLs
    List<String> airlineImages = [
      'assets/airnamibia.png',
      'assets/fastjet.png',
      'assets/iata.png',
      'assets/kenya.jpeg',
      'assets/rwand.png',
      'assets/southAfrican.png',
      'assets/ethiopian.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          if (user.name != "")
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  CustomColors.lightPrimaryColor,
                ),
              ),
              icon: Icon(
                Icons.logout,
                color: CustomColors.primaryColor,
              ),
              onPressed: () {
                logoutAction(context, user.token);
              },
              label: Text(
                "Logout",
                style: GoogleFonts.roboto(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          else
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  CustomColors.lightPrimaryColor,
                ),
              ),
              icon: Icon(
                Icons.login,
                color: CustomColors.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      LoginScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin =
                        Offset(1.0, 0.0); // Change for different animation
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ));
              },
              label: Text(
                "Login",
                style: GoogleFonts.roboto(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          SizedBox(
            width: 8,
          ),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        centerTitle: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                fit: BoxFit.cover,
                "assets/logo.png",
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: [
                Text(
                  "Abisiniya",
                  style: GoogleFonts.lato(
                    color: CustomColors.lightPrimaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Travels & Tourism",
                  style: GoogleFonts.openSans(
                    color: CustomColors.lightPrimaryColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                'assets/loading.gif',
                width: 100,
                height: 100,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final apartments = snapshot.data!['apartments'] as List<Apartment>;
            final vehicles = snapshot.data!['vehicles'] as List<Vehicle>;

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User information bar
                    UserInfo(),
                    SizedBox(
                      height: 20,
                    ),
                    // Message
                    Text(
                      "Begin your Voyage Here",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: CustomColors.smokyBlackColor,
                      ),
                    ),
                    Text(
                      "Unlock your next level experience",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff91A3B0),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // Services menu options
                    Container(
                      height: 148,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildServicesCard(
                              "Flights",
                              "assets/airplane-ticket.png",
                              FlightScreen.routeName),
                          _buildServicesCard("Cars", "assets/car.png",
                              VehicleScreen.routeName),
                          _buildServicesCard(
                              "Apartments",
                              "assets/apartments.png",
                              ApartmentScreen.routeName),
                          _buildServicesCard("Buses", "assets/transport.png",
                              VehicleScreen.routeName),
                          _buildServicesCard(
                              "Airport Shuttles",
                              "assets/airport-shuttle.png",
                              VehicleScreen.routeName),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // "Most Popular" section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Popular Apartments",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ApartmentScreen.routeName);
                          },
                          child: Row(
                            children: [
                              Text(
                                "View all",
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: CustomColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: apartments.length,
                        itemBuilder: (context, index) {
                          return _buildApartmentCard(
                              context, apartments[index]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // "Most Popular Cars" section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Popular Cars",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(VehicleScreen.routeName);
                          },
                          child: Row(
                            children: [
                              Text(
                                "View all",
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: CustomColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: vehicles.length > 10 ? 10 : vehicles.length,
                        itemBuilder: (context, index) {
                          return _buildVehicleCard(context, vehicles[index]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // "Most Popular Airlines" section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Popular Airlines",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        // No need for a "View all" option if only images are displayed
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: airlineImages.length,
                        itemBuilder: (context, index) {
                          return _buildAirlineCard(airlineImages[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  GestureDetector _buildServicesCard(
      String label, String path, String routeName) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: AnimatedScale(
        duration: _duration,
        scale: _scale,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(16),
          width: 120,
          decoration: BoxDecoration(
            color: CustomColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                path,
                height: 72,
                width: 72,
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: CustomColors.smokyBlackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApartmentCard(BuildContext context, Apartment apartment) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailApartmentScreen.routeName,
          arguments: apartment,
        );
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: apartment.images.isNotEmpty
                  ? Image.network(
                      apartment.images[0],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 120,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
            ),
            SizedBox(height: 8),
            Text(
              "  ${apartment.text}",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "   ${apartment.address}",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              "   \$${apartment.price} / night",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: CustomColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context, Vehicle vehicle) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          VehicleDetailScreen.routeName,
          arguments: vehicle,
        );
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: vehicle.images.isNotEmpty
                      ? Image.network(
                          vehicle.images,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: double.infinity,
                          height: 120,
                          color: Colors.grey,
                          child: const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_gas_station,
                            size: 14, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          vehicle.fuelType,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "  ${vehicle.make}",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Icon(Icons.location_city, size: 14, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  vehicle.country,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "  \$${vehicle.price} / day",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: CustomColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAirlineCard(String imagePath) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

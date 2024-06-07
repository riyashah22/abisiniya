import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/about/about.dart';
import 'package:abisiniya/screens/apartments/detail_apartment_screen.dart';
import 'package:abisiniya/screens/vehicles/vehicle_detail_screen.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:line_icons/line_icons.dart';
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
  List<Vehicle> vehicleList = [];
  List<Apartment> apartmentsList = [];

  void logoutAction(BuildContext context, String token) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Logging out..."),
            ],
          ),
        );
      },
    );

    var result = await authServices.logout(context, token);

    Navigator.pop(context);

    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } else {
      showErrorMessage(context, "Something went wrong");
    }
  }

  double _scale = 1.0;
  Duration _duration = Duration(milliseconds: 200);

  Future<Map<String, dynamic>> fetchData() async {
    final apartments = await apartmentServices.getAllApartments(context);
    final vehicles = await vehicleServices.getAllVehicles(context);
    return {
      'apartments': apartments,
      'vehicles': vehicles,
    };
  }

  Future<void> fetchApartments() async {
    List<Apartment> fetchedApartments =
        await apartmentServices.getAllApartments(context);
    setState(() {
      apartmentsList = fetchedApartments;
    });
  }

  Future<void> fetchVehicles() async {
    List<Vehicle> fetchedVehicles =
        await vehicleServices.getAllVehicles(context);

    setState(() {
      vehicleList = fetchedVehicles;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchApartments();
    fetchVehicles();
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

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          if (user.name != "")
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
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
                style: GoogleFonts.raleway(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          else
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
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
        toolbarHeight: height * 0.12,
        centerTitle: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                fit: BoxFit.cover,
                "assets/logo.png",
                height: height * 0.06,
                width: width * 0.13,
              ),
            ),
            SizedBox(
              width: 12,
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
                Text(
                  "Travels & Tourism",
                  style: GoogleFonts.raleway(
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User information bar
              UserInfo(),
              SizedBox(
                height: height * 0.02,
              ),
              // Message
              Text(
                "Begin your Voyage Here",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: CustomColors.smokyBlackColor,
                ),
              ),
              Text(
                "Unlock your next level experience",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xff91A3B0),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              // Services menu options
              Container(
                height: height * 0.18,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildServicesCard("Flights", "assets/airplane-ticket.png",
                        FlightScreen.routeName),
                    _buildServicesCard(
                        "Cars", "assets/car.png", VehicleScreen.routeName),
                    _buildServicesCard("Apartments", "assets/apartments.png",
                        ApartmentScreen.routeName),
                    _buildServicesCard("Buses", "assets/transport.png",
                        VehicleScreen.routeName),
                    // _buildServicesCard("Airport Shuttles",
                    //     "assets/airport-shuttle.png", VehicleScreen.routeName),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              // "Most Popular" section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Elite Residences",
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
                height: height * 0.02,
              ),
              Container(
                height: height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      apartmentsList.length > 10 ? 10 : apartmentsList.length,
                  itemBuilder: (context, index) {
                    return _buildApartmentCard(context, apartmentsList[index]);
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              // "Most Popular Cars" section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Premier Rides",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(VehicleScreen.routeName);
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
                height: height * 0.02,
              ),
              Container(
                height: height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vehicleList.length > 10 ? 10 : vehicleList.length,
                  itemBuilder: (context, index) {
                    return _buildVehicleCard(context, vehicleList[index]);
                  },
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Popular Airlines",
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "we are affliated with",
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.3,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Single row for horizontal scroll
                    childAspectRatio: 1, // Adjust aspect ratio as needed
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _buildAirlineCard(airlineImages[index]);
                  },
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      CustomColors.primaryColor,
                    ),
                  ),
                  icon: Icon(
                    LineIcons.infoCircle,
                    color: CustomColors.lightPrimaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                  label: Text(
                    "Know more about us",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.lightPrimaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // FutureBuilder<Map<String, dynamic>>(
      //   future: fetchData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: Image.asset(
      //           'assets/loading.gif',
      //           width: 100,
      //           height: 100,
      //         ),
      //       );
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (!snapshot.hasData) {
      //       return Center(child: Text('No data available'));
      //     } else {
      //       final apartments = snapshot.data!['apartments'] as List<Apartment>;
      //       final vehicles = snapshot.data!['vehicles'] as List<Vehicle>;

      //       return SingleChildScrollView(
      //         child: Container(
      //           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               // User information bar
      //               UserInfo(),
      //               SizedBox(
      //                 height: height * 0.02,
      //               ),
      //               // Message
      //               Text(
      //                 "Begin your Voyage Here",
      //                 style: GoogleFonts.raleway(
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 22,
      //                   color: CustomColors.smokyBlackColor,
      //                 ),
      //               ),
      //               Text(
      //                 "Unlock your next level experience",
      //                 style: GoogleFonts.raleway(
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 18,
      //                   color: Color(0xff91A3B0),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: height * 0.01,
      //               ),
      //               // Services menu options
      //               Container(
      //                 height: height * 0.18,
      //                 child: ListView(
      //                   scrollDirection: Axis.horizontal,
      //                   children: [
      //                     _buildServicesCard(
      //                         "Flights",
      //                         "assets/airplane-ticket.png",
      //                         FlightScreen.routeName),
      //                     _buildServicesCard("Cars", "assets/car.png",
      //                         VehicleScreen.routeName),
      //                     _buildServicesCard(
      //                         "Apartments",
      //                         "assets/apartments.png",
      //                         ApartmentScreen.routeName),
      //                     _buildServicesCard("Buses", "assets/transport.png",
      //                         VehicleScreen.routeName),
      //                     _buildServicesCard(
      //                         "Airport Shuttles",
      //                         "assets/airport-shuttle.png",
      //                         VehicleScreen.routeName),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: height * 0.03,
      //               ),
      //               // "Most Popular" section
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     "Elite Residences",
      //                     style: GoogleFonts.raleway(
      //                       fontWeight: FontWeight.w700,
      //                       fontSize: 24,
      //                     ),
      //                   ),
      //                   GestureDetector(
      //                     onTap: () {
      //                       Navigator.of(context)
      //                           .pushNamed(ApartmentScreen.routeName);
      //                     },
      //                     child: Row(
      //                       children: [
      //                         Text(
      //                           "View all",
      //                           style: GoogleFonts.raleway(
      //                             fontWeight: FontWeight.w500,
      //                             fontSize: 16,
      //                             color: CustomColors.primaryColor,
      //                           ),
      //                         ),
      //                         Icon(
      //                           Icons.arrow_forward_ios,
      //                           size: 16,
      //                           color: CustomColors.primaryColor,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: height * 0.02,
      //               ),
      //               Container(
      //                 height: height * 0.22,
      //                 child: ListView.builder(
      //                   scrollDirection: Axis.horizontal,
      //                   itemCount:
      //                       apartments.length > 10 ? 10 : apartments.length,
      //                   itemBuilder: (context, index) {
      //                     return _buildApartmentCard(
      //                         context, apartments[index]);
      //                   },
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: height * 0.03,
      //               ),
      //               // "Most Popular Cars" section
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     "Premier Rides",
      //                     style: GoogleFonts.raleway(
      //                       fontWeight: FontWeight.w700,
      //                       fontSize: 24,
      //                     ),
      //                   ),
      //                   GestureDetector(
      //                     onTap: () {
      //                       Navigator.of(context)
      //                           .pushNamed(VehicleScreen.routeName);
      //                     },
      //                     child: Row(
      //                       children: [
      //                         Text(
      //                           "View all",
      //                           style: GoogleFonts.raleway(
      //                             fontWeight: FontWeight.w500,
      //                             fontSize: 16,
      //                             color: CustomColors.primaryColor,
      //                           ),
      //                         ),
      //                         Icon(
      //                           Icons.arrow_forward_ios,
      //                           size: 16,
      //                           color: CustomColors.primaryColor,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: height * 0.02,
      //               ),
      //               Container(
      //                 height: height * 0.25,
      //                 child: ListView.builder(
      //                   scrollDirection: Axis.horizontal,
      //                   itemCount: vehicles.length > 10 ? 10 : vehicles.length,
      //                   itemBuilder: (context, index) {
      //                     return _buildVehicleCard(context, vehicles[index]);
      //                   },
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: height * 0.02,
      //               ),
      //               Container(
      //                 width: double.infinity,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       "Popular Airlines",
      //                       style: GoogleFonts.raleway(
      //                         fontWeight: FontWeight.w700,
      //                         fontSize: 30,
      //                       ),
      //                     ),
      //                     Text(
      //                       "we are affliated with",
      //                       style: GoogleFonts.raleway(
      //                         fontWeight: FontWeight.w300,
      //                         fontSize: 18,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: height * 0.02,
      //               ),
      //               Container(
      //                 height: height * 0.3,
      //                 child: GridView.builder(
      //                   scrollDirection: Axis.vertical,
      //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisCount: 3, // Single row for horizontal scroll
      //                     childAspectRatio: 1, // Adjust aspect ratio as needed
      //                   ),
      //                   itemCount: 6,
      //                   itemBuilder: (context, index) {
      //                     return _buildAirlineCard(airlineImages[index]);
      //                   },
      //                 ),
      //               ),
      //               Container(
      //                 width: double.infinity,
      //                 margin: EdgeInsets.symmetric(vertical: 20),
      //                 child: OutlinedButton.icon(
      //                   style: ButtonStyle(
      //                     backgroundColor: WidgetStatePropertyAll(
      //                       CustomColors.primaryColor,
      //                     ),
      //                   ),
      //                   icon: Icon(
      //                     LineIcons.infoCircle,
      //                     color: CustomColors.lightPrimaryColor,
      //                   ),
      //                   onPressed: () {
      //                     Navigator.of(context)
      //                         .pushNamed(AboutScreen.routeName);
      //                   },
      //                   label: Text(
      //                     "Know more about us",
      //                     style: GoogleFonts.roboto(
      //                       fontSize: 20,
      //                       fontWeight: FontWeight.w700,
      //                       color: CustomColors.lightPrimaryColor,
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }

  GestureDetector _buildServicesCard(
      String label, String path, String routeName) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: AnimatedScale(
        duration: _duration,
        scale: _scale,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(16),
          width: width * 0.3,
          decoration: BoxDecoration(
            color: CustomColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                path,
                height: height * 0.08,
                width: width * 0.25,
              ),
              SizedBox(height: height * 0.01),
              AutoSizeText(
                label,
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: CustomColors.smokyBlackColor,
                ),
                minFontSize: 8,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApartmentCard(BuildContext context, Apartment apartment) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailApartmentScreen.routeName,
          arguments: apartment,
        );
      },
      child: Container(
        width: width * 0.38,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: apartment.images.isNotEmpty
                  ? Image.network(
                      apartment.images[0],
                      height: height * 0.13,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: height * 0.13,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "  ${apartment.text}",
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "   ${apartment.address}",
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: height * 0.008),
            Text(
              "   \$${apartment.price} / night",
              style: GoogleFonts.raleway(
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          VehicleDetailScreen.routeName,
          arguments: vehicle,
        );
      },
      child: Container(
        width: width * 0.35,
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
                          height: height * 0.13,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: double.infinity,
                          height: height * 0.13,
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
                          style: GoogleFonts.raleway(
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
            SizedBox(height: height * 0.01),
            Text(
              "  ${vehicle.make}",
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Icon(Icons.location_city, size: 14, color: Colors.grey[600]),
                SizedBox(width: height * 0.02),
                Text(
                  vehicle.country,
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.008),
            Text(
              "  \$${vehicle.price} / day",
              style: GoogleFonts.raleway(
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
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.40,
      margin: EdgeInsets.only(right: 16, bottom: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

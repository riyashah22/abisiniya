import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/apartments/apartments.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/screens/flights/flights.dart';
import 'package:abisiniya/screens/vehicles/vehicles.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screens";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServices authServices = AuthServices();
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          if (user.name != "")
            ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                CustomColors.lightPrimaryColor,
              )),
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
                  backgroundColor: WidgetStatePropertyAll(
                CustomColors.lightPrimaryColor,
              )),
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
      body: Container(
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
                  _buildServicesCard("Flights", "assets/airplane-ticket.png",
                      FlightScreen.routeName),
                  _buildServicesCard(
                      "Cars", "assets/car.png", VehicleScreen.routeName),
                  _buildServicesCard("Apartments", "assets/apartments.png",
                      ApartmentScreen.routeName),
                  _buildServicesCard(
                      "Buses", "assets/transport.png", VehicleScreen.routeName),
                  _buildServicesCard("Airport Shuttles",
                      "assets/airport-shuttle.png", VehicleScreen.routeName),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Most Featured Properties",
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesCard(String label, String path, String route) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: AnimatedContainer(
        duration: _duration,
        transform: Matrix4.identity()..scale(_scale),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Color(0xffF5F5F5),
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
            SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

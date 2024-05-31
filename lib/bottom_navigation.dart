import 'package:abisiniya/screens/about/about.dart';
import 'package:abisiniya/screens/apartments/apartments.dart';
import 'package:abisiniya/screens/flights/flights.dart';
import 'package:abisiniya/screens/vehicles/vehicles.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ApartmentScreen(),
    VehicleScreen(),
    FlightScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Abisiniya",
              style: GoogleFonts.lato(
                color: CustomColors.textPrimaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Travels & Tourism",
              style: GoogleFonts.openSans(
                color: CustomColors.textPrimaryColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: CustomColors.backgroundPrimaryColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).primaryColor,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.building,
                  text: 'Apartments',
                ),
                GButton(
                  icon: LineIcons.car,
                  text: 'Vehicles',
                ),
                GButton(
                  icon: LineIcons.planeDeparture,
                  text: 'Flights',
                ),
                GButton(
                  icon: LineIcons.infoCircle,
                  text: 'About',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

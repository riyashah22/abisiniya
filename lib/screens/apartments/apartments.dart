import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/apartments/apartment_dashboard.dart';
import 'package:abisiniya/screens/apartments/apartment_item.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:provider/provider.dart';

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({
    super.key,
  });

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  List<Apartment> apartments = [];
  ApartmentServices apartmentServices = ApartmentServices();
  AuthServices authServices = AuthServices();

  Future<void> fetchApartments() async {
    List<Apartment> fetchedApartments =
        await apartmentServices.getAllApartments(context);

    apartments = fetchedApartments;
  }

  void logoutAction(BuildContext context, String token) {
    authServices.logout(context, token);
  }

  @override
  void initState() {
    fetchApartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3E6837), // Primary color
              borderRadius: BorderRadius.circular(10), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: const Offset(
                      0, 3), // Shadow position, changes height of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // Padding for inner content
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.white),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      user.name == "" ? "Guest" : user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Making username bold
                        fontSize: 16, // Adjusting font size
                        color: Colors.white, // Username text color
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                if (user.name != "")
                  ElevatedButton(
                    onPressed: () {
                      // Handle logout
                      logoutAction(context, user.token);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xfff8fbf1), // Secondary color
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Color(0xFF3E6837), // Text color of the button
                      ),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xfff8fbf1), // Secondary color
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF3E6837), // Text color of the button
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          user.token == ""
              ? const SizedBox()
              : ElevatedButton.icon(
                  icon: const Icon(
                    Icons.analytics,
                    color: Color(0xfff8fbf1), // Secondary color
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6837), // Primary color
                    elevation: 0, // Remove button elevation
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Same as container
                    ),
                  ),
                  label: const Text(
                    "Dashboard",
                    style: TextStyle(
                        color: Colors.white), // Adjust text color as needed
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ApartmentDashboard.routeName);
                  },
                ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              "Find your Apartments",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3E6837), // Primary color
                  ),
            ),
          ),
          // Display list of apartments
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.48,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: FutureBuilder(
                future: fetchApartments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: apartments.length,
                      itemBuilder: (context, index) {
                        return ApartmentItem(apartment: apartments[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

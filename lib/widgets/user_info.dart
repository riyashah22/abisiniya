import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffA3AF9F), // Primary color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset:
                const Offset(0, 3), // Shadow position, changes height of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ), // Padding for inner content
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: Color(0xff000000)),
              const SizedBox(
                width: 8,
              ),
              Text(
                user.name == "" ? "Guest" : user.name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, // Making username bold
                  fontSize: 22, // Adjusting font size
                  color: Color(0xff000000), // Username text color
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          if (user.token != "")
            ElevatedButton.icon(
              icon: Icon(
                Icons.analytics,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(ApartmentDashboard.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff004162), // Secondary color
              ),
              label: const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white, // Text color of the button
                ),
              ),
            )
        ],
      ),
    );
  }
}

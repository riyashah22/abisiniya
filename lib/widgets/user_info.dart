import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/dashboard/dashboard_screen.dart';
import 'package:abisiniya/themes/custom_colors.dart';
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
        color: CustomColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5), // Shadow color
        //     spreadRadius: 2, // Spread radius
        //     blurRadius: 5, // Blur radius
        //     offset:
        //         const Offset(0, 3), // Shadow position, changes height of shadow
        //   ),
        // ],
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
              Icon(Icons.person, color: CustomColors.smokyBlackColor),
              const SizedBox(
                width: 8,
              ),
              Text(
                user.name == "" ? "Guest" : user.name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: CustomColors.smokyBlackColor,
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
                backgroundColor: CustomColors.blueColor,
              ),
              label: const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}

import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();

    void logoutAction(BuildContext context, String token) {
      authServices.logout(context, token);
    }

    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3E6837), // Primary color
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
                backgroundColor: const Color(0xfff8fbf1), // Secondary color
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
                backgroundColor: const Color(0xfff8fbf1), // Secondary color
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
    );
  }
}

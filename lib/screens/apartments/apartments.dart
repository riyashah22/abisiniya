import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Apartments extends StatelessWidget {
  const Apartments({super.key});

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
              color: Theme.of(context)
                  .secondaryHeaderColor, // Change to your desired color
              borderRadius: BorderRadius.circular(16),
              border: const Border(
                bottom:
                    BorderSide(color: Colors.grey, width: 1.0), // Add a border
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Available Apartments",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.outlined(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.person_2_rounded,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print(user.token);
              },
              child: Text("Get provider data"))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/logo.png"),
          Column(
            children: [
              Card(
                child: Expanded(
                  child: Container(
                    // height: 80,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_moderator_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("About Us"),
                          ],
                        ),
                        Text("Kriva")
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.contact_support,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Contact Us"),
                          ],
                        ),
                        Text("Kriva")
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Privacy Policy"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

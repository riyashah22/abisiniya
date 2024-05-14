import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                width: double.infinity, // Adjust the width as needed
                height: 160, // Adjust the height as needed
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.announcement_rounded,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "About Us",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    "We pride ourselves on our outstanding customer service. Let us take you across the world in easier and affordable ways.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.contact_support,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Zimbabwe",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text("Phone: +263 777 223 158",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          Text(
                              "New Office Address: Cnr Prince Edward and Lezard, Milton park",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 17)),
                          Text("Location: Harare, Zimbabwe",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          Text("Email: info@abisiniya.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          Text("Website: www.abisiniya.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "South Africa",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text("Phone: +27 65 532 6408",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          Text(
                              "Location: Add 28 Mint Road, 3rd Floor, Fordsburg, Johannesburg, South Africa",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 17)),
                          Text("Email: info@abisiniya.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          Text("Website: www.abisiniya.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

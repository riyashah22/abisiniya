import 'package:flutter/material.dart';
import 'package:abisiniya/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/splash.jpeg',
                width: 700, // Set the width of the circle
                height: 700, // Set the height of the circle
                fit: BoxFit.fill, // Ensure the image covers the circle
              ),
            ), // Add your logo here
            SizedBox(height: 20),
            Text(
              "Lets Make a Plan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}

import "package:abisiniya/bottom_navigation.dart";
import "package:abisiniya/screens/apartments/apartment_dashboard.dart";
import "package:abisiniya/screens/apartments/detail_apartment_screen.dart";
import "package:abisiniya/screens/auth/login.dart";
import "package:abisiniya/screens/auth/otpVerification.dart";
import "package:abisiniya/screens/auth/signup.dart";
import "package:abisiniya/screens/vehicles/detail_vehicle_screen.dart";
import "package:flutter/material.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case OtpVerificationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OtpVerificationScreen(),
      );
    case VehicleDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VehicleDetailScreen(),
      );
    case DetailApartmentScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DetailApartmentScreen(),
      );
    case ApartmentDashboard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ApartmentDashboard(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

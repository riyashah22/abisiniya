import "package:abisiniya/bottom_navigation.dart";
import "package:abisiniya/home_screen.dart";
import "package:abisiniya/screens/apartments/add_apartment.dart";
import "package:abisiniya/screens/apartments/apartments.dart";
import "package:abisiniya/screens/dashboard/dashboard_screen.dart";
import "package:abisiniya/screens/apartments/detail_apartment_screen.dart";
import "package:abisiniya/screens/auth/login.dart";
import "package:abisiniya/screens/auth/otpVerification.dart";
import "package:abisiniya/screens/auth/signup.dart";
import "package:abisiniya/screens/flights/flights.dart";
import "package:abisiniya/screens/vehicles/add_vehicle.dart";
import "package:abisiniya/screens/vehicles/bus_detail_screen.dart";
import "package:abisiniya/screens/vehicles/detail_vehicle_screen.dart";
import "package:abisiniya/screens/vehicles/vehicles.dart";
import "package:flutter/material.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
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
    case BottomNav.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNav(),
      );

    case OtpVerificationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OtpVerificationScreen(),
      );
    case VehicleScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VehicleScreen(),
      );
    case VehicleDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VehicleDetailScreen(),
      );
    case AddVehicleScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddVehicleScreen(),
      );
    case BusDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BusDetailScreen(),
      );
    case DetailApartmentScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DetailApartmentScreen(),
      );
    case ApartmentScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ApartmentScreen(),
      );
    case ApartmentDashboard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ApartmentDashboard(),
      );
    case AddApartmentForm.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddApartmentForm(),
      );
    case FlightScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FlightScreen(),
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

import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/screens/apartments/apartment_dashboard.dart';
import 'package:abisiniya/screens/apartments/apartment_item.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:abisiniya/services/apartment_services.dart';

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({Key? key});

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  List<Apartment> apartments = [];
  ApartmentServices apartmentServices = ApartmentServices();

  Future<void> fetchApartments() async {
    List<Apartment> fetchedApartments =
        await apartmentServices.getAllApartments(context);

    apartments = fetchedApartments;
  }

  @override
  void initState() {
    fetchApartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: const Text("Login")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ApartmentDashboard.routeName);
                  },
                  child: const Text("Dashboard")),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          // Display list of apartments
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.64,
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

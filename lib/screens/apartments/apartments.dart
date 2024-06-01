import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/screens/apartments/apartment_item.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:abisiniya/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:abisiniya/services/apartment_services.dart';

class ApartmentScreen extends StatefulWidget {
  static const String routeName = "/apartment-screen";
  const ApartmentScreen({
    super.key,
  });

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  List<Apartment> apartments = [];
  ApartmentServices apartmentServices = ApartmentServices();
  AuthServices authServices = AuthServices();

  Future<void> fetchApartments() async {
    List<Apartment> fetchedApartments =
        await apartmentServices.getAllApartments(context);

    apartments = fetchedApartments;
  }

  void logoutAction(BuildContext context, String token) {
    authServices.logout(context, token);
  }

  @override
  void initState() {
    fetchApartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarSecondaryScreen(context, "Apartments"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            UserInfo(),

            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                "Most Frequent Properties",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3E6837), // Primary color
                    ),
              ),
            ),
            // Display list of apartments
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.48,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                  future: fetchApartments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Image.asset(
                          'assets/loading.gif',
                          width: 100,
                          height: 100,
                        ),
                      );
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
      ),
    );
  }
}

import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/screens/apartments/apartment_item.dart';
import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  Future<void> fetchApartments() async {
    try {
      List<Apartment> fetchedApartments =
          await apartmentServices.getAllApartments(context);
      setState(() {
        apartments = fetchedApartments;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error by showing a dialog or a snackbar
      print('Error fetching apartments: $e');
    }
  }

  void logoutAction(BuildContext context, String token) {
    authServices.logout(context, token);
  }

  @override
  void initState() {
    super.initState();
    fetchApartments();
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    List<Apartment> searchedApartments =
        await apartmentServices.searchApartment(
      context,
      searchController.text,
    );

    setState(() {
      apartments = searchedApartments;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarSecondaryScreen(context, "Book Apartment"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 4),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Effortless Rental",
                        style: GoogleFonts.roboto(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          color: CustomColors.smokyBlackColor, // Primary color
                        ),
                      ),
                      Text(
                        "Properties",
                        style: GoogleFonts.roboto(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: CustomColors.smokyBlackColor, // Primary color
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/apartments.png",
                    height: 66,
                    width: 66,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 18,
            ),
            // Search bar with button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search apartments...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onSearch,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            // Display list of apartments
            Expanded(
              child: isLoading
                  ? Center(
                      child: Image.asset(
                        'assets/loading.gif',
                        width: 100,
                        height: 100,
                      ),
                    )
                  : apartments.isEmpty
                      ? Center(child: Text('No apartments found'))
                      : ListView.builder(
                          itemCount: apartments.length,
                          itemBuilder: (context, index) {
                            return ApartmentItem(apartment: apartments[index]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

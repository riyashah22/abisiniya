import 'package:flutter/material.dart';

import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/apartment_services.dart';

class Apartments extends StatefulWidget {
  const Apartments({Key? key});

  @override
  State<Apartments> createState() => _ApartmentsState();
}

class _ApartmentsState extends State<Apartments> {
  List<Apartment> apartments = [];
  ApartmentServices apartmentServices = ApartmentServices();

  @override
  void initState() {
    super.initState();
    fetchApartments();
  }

  Future<void> fetchApartments() async {
    List<Apartment> fetchedApartments =
        await apartmentServices.getAllApartments(context);
    apartments = fetchedApartments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff3e6837),
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  bottom: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Available Apartments",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                        icon: const Icon(Icons.person_2_rounded),
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            // Display list of apartments

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: FutureBuilder(
                future: fetchApartments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: apartments.length,
                      itemBuilder: (context, index) {
                        return ApartmentItem(apartment: apartments[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Apartment {
  final String image;
  final String text;
  final String address;
  final String location;
  final int guest;
  final int bathroom;
  final int bedroom;
  final int price;

  Apartment({
    required this.image,
    required this.text,
    required this.address,
    required this.location,
    required this.guest,
    required this.bathroom,
    required this.bedroom,
    required this.price,
  });
}

class ApartmentItem extends StatefulWidget {
  final Apartment apartment;

  const ApartmentItem({Key? key, required this.apartment}) : super(key: key);

  @override
  State<ApartmentItem> createState() => _ApartmentItemState();
}

class _ApartmentItemState extends State<ApartmentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          // Display the image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.apartment.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // Details container positioned above the image
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display name
                  Text(
                    widget.apartment.text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Display address
                  Text(
                    widget.apartment.address,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Display location with icon
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.apartment.location,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Display price
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Starts From",
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xff265022),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '\$${widget.apartment.price} / night',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:abisiniya/screens/apartments/apartments.dart';

class DetailApartmentScreen extends StatelessWidget {
  static const String routeName = '/detail-apartment-screen';

  const DetailApartmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Apartment apartment =
        ModalRoute.of(context)!.settings.arguments as Apartment;

    return Scaffold(
      appBar: AppBar(
        title: Text(apartment.text),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image
                  Image.network(
                    apartment.image,
                    fit: BoxFit.cover,
                    height: 200,
                  ),

                  // Location Card
                  Card(
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Address: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${apartment.address}\n',
                                ),
                                TextSpan(
                                  text: 'City: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${apartment.location}\n',
                                ),
                                TextSpan(
                                  text: 'Country: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${apartment.text}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Specs and Utilities Card
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Specs and Utilities',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Guest: ${apartment.guest}'),
                              Text('Bathroom: ${apartment.bathroom}'),
                              Text('Bedroom: ${apartment.bedroom}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${apartment.price} / night',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement book now functionality
                    },
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

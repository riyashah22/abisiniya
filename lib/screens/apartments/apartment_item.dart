import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/screens/apartments/detail_apartment_screen.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class ApartmentItem extends StatefulWidget {
  final Apartment apartment;

  const ApartmentItem({Key? key, required this.apartment}) : super(key: key);

  @override
  State<ApartmentItem> createState() => _ApartmentItemState();
}

class _ApartmentItemState extends State<ApartmentItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailApartmentScreen.routeName,
          arguments: widget.apartment,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            // Display the image if available
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: widget.apartment.images.isNotEmpty
                  ? Image.network(
                      widget.apartment.images[0],
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.white,
                      ),
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
                  color: Colors.white.withOpacity(0.8),
                  border:
                      Border.all(color: CustomColors.primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display name
                          Text(
                            widget.apartment.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 8),
                          // Display location with icon
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 23,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.apartment.location,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xff265022),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '\$${widget.apartment.price} / night',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ), // Added SizedBox for spacing
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.king_bed),
                              SizedBox(width: 8),
                              Text("Bedroom: "),
                              SizedBox(width: 13),
                              Text(widget.apartment.bedroom
                                  .toString()), // Example: Replace '3' with the actual number of bedrooms
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.bathtub),
                              SizedBox(width: 8),
                              Text("Bathroom: "),
                              SizedBox(width: 8),
                              Text(widget.apartment.bathroom
                                  .toString()), // Example: Replace '2' with the actual number of bathrooms
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.people),
                              SizedBox(width: 8),
                              Text("Guest: "),
                              SizedBox(width: 30),
                              Text(widget.apartment.guest
                                  .toString()), // Example: Replace '4' with the actual number of guests
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

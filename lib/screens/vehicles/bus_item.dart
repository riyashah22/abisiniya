import 'package:abisiniya/models/bus.dart';
import 'package:abisiniya/screens/vehicles/bus_detail_screen.dart';
import 'package:flutter/material.dart';

class BusItem extends StatefulWidget {
  final Bus bus;
  const BusItem({super.key, required this.bus});

  @override
  State<BusItem> createState() => _BusItemState();
}

class _BusItemState extends State<BusItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.16,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: height * 0.16,
              width: width * 0.45,
              child: Image.network(
                widget.bus.images,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: height * 0.15,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.bus.model,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.fade,
                  ),
                  SizedBox(
                    height: height * 0.001,
                  ),
                  Text(
                    widget.bus.make,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '\$${widget.bus.price}/km',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                BusDetailScreen.routeName,
                                arguments: widget.bus,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Decrease the border radius
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8), // Adjust padding
                            ),
                            child: const Text(
                              "Book ride",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13, // Adjust font size
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          )
                        ],
                      ),
                    ),
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

import 'package:abisiniya/models/vehicles.dart';
import 'package:flutter/material.dart';

class VehicleItem extends StatefulWidget {
  final Vehicle vehicle;
  const VehicleItem({super.key, required this.vehicle});

  @override
  State<VehicleItem> createState() => _VehicleItemState();
}

class _VehicleItemState extends State<VehicleItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
              height: 170,
              width: 180,
              child: Image.network(
                widget.vehicle.images,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 170,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.vehicle.model,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.vehicle.make,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.vehicle.price}/day',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
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
                                fontSize: 14, // Adjust font size
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
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

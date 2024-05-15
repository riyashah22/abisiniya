import 'package:abisiniya/models/vehicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      margin: EdgeInsets.all(16),
      // color: Colors.red,
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.vehicle.images),
              ),
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.vehicle.model,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.vehicle.make),
                      Text(widget.vehicle.year.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Icon(FontAwesomeIcons.gear),
                          SizedBox(width: 5),
                          Text(widget.vehicle.transmission),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.gas_meter_outlined),
                          SizedBox(width: 5),
                          Text(widget.vehicle.fuelType),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.vehicle.price.toString()),
                      ElevatedButton(onPressed: () {}, child: Text("Book ride"))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

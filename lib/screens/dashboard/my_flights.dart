import 'package:abisiniya/services/flight_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFlights extends StatefulWidget {
  const MyFlights({super.key});

  @override
  State<MyFlights> createState() => _MyFlightsState();
}

class _MyFlightsState extends State<MyFlights> {
  List<dynamic> myFlights = [];
  FlightServices flightServices = FlightServices();

  Future<void> fetchUserApartments() async {
    final flights = await flightServices.userFlightRequests(context);
    if (flights != null) {
      setState(() {
        myFlights = flights;
      });
    }
    print(myFlights[0]);
  }

  @override
  void initState() {
    fetchUserApartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        itemCount: myFlights.length,
        itemBuilder: (context, index) {
          return FlightRequestItem(request: myFlights[index]);
        },
      ),
    );
  }

  Widget FlightRequestItem({required dynamic request}) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/aeroplane.png",
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        request['airline'],
                        style: GoogleFonts.roboto(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          'Flight Id ${myFlights[0]['flight_request_id']}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.flight_takeoff_outlined),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          request['from'],
                          softWrap: true,
                        ),
                      ),
                      SizedBox(width: 26),
                      Icon(Icons.flight_land_outlined),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          request['to'],
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Departure Date',
                              style: GoogleFonts.roboto(
                                color: Color(0xff708090),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(request['departure_date']),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 35,
                          )),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Return Date',
                              style: GoogleFonts.roboto(
                                color: Color(0xff708090),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              request['return_date'] == null
                                  ? 'N/A'
                                  : request['return_date'].toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width:
                            120, // Adjust width to control the horizontal size
                        height:
                            40, // Adjust height to control the vertical size
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              25), // Adjust the radius to make it more oval
                          border: Border.all(
                            color: CustomColors
                                .primaryColor, // Optional border color
                            width: 2, // Optional border width
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.airline_seat_recline_extra_sharp),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                request['travel_class'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width:
                            120, // Adjust width to control the horizontal size
                        height:
                            50, // Adjust height to control the vertical size
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              25), // Adjust the radius to make it more oval
                          border: Border.all(
                            color: CustomColors
                                .primaryColor, // Optional border color
                            width: 2, // Optional border width
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              request['trip_option'] == 'Round Trip'
                                  ? Icon(Icons.autorenew)
                                  : Icon(Icons.location_on),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                request['trip_option'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Payment Status:",
                        style: GoogleFonts.roboto(
                          color: Color(0xff708090),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        request['status'],
                        style: GoogleFonts.roboto(
                          color: request['status'] == 'Not Paid'
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

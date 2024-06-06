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
  bool isLoading = false;
  FlightServices flightServices = FlightServices();

  Future<void> fetchUserApartments() async {
    setState(() {
      isLoading = true;
    });
    final flights = await flightServices.userFlightRequests(context);
    if (flights != null) {
      setState(() {
        isLoading = false;
        myFlights = flights;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserApartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (isLoading)
      return Container(
        height: height * 0.6,
        child: Center(
          child: Center(
            child: Image.asset(
              "assets/loading.gif",
              height: 100,
              width: 100,
            ),
          ),
        ),
      );
    else if (myFlights.isEmpty)
      return Container(
        height: height * 0.6,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              Image.asset("assets/noDataFound.gif"),
              Text(
                "No Data Found",
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.smokyBlackColor,
                ),
              ),
            ],
          ),
        ),
      );
    else
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Card(
            color: Colors.white,
            elevation: 7,
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
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Flight id: ',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' ${request['flight_request_id']}',
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flight_takeoff_outlined,
                        color: CustomColors.smokyBlackColor.withOpacity(0.8),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          request['from'],
                          softWrap: true,
                          style: GoogleFonts.openSans(),
                        ),
                      ),
                      SizedBox(width: 26),
                      Icon(
                        Icons.flight_land_outlined,
                        color: CustomColors.smokyBlackColor.withOpacity(0.8),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          request['to'],
                          softWrap: true,
                          style: GoogleFonts.openSans(),
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
                            Text(
                              request['departure_date'],
                              style: GoogleFonts.openSans(),
                            ),
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
                              style: GoogleFonts.openSans(),
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
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: CustomColors.primaryColor,
                            width: 2,
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
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: CustomColors.primaryColor,
                            width: 2,
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
                                style: GoogleFonts.openSans(
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
                        style: GoogleFonts.openSans(
                          color: request['status'] == 'Not Paid'
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w700,
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

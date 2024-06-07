import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailApartmentScreen extends StatefulWidget {
  static const String routeName = '/detail-apartment-screen';

  const DetailApartmentScreen({super.key});

  @override
  _DetailApartmentScreenState createState() => _DetailApartmentScreenState();
}

class _DetailApartmentScreenState extends State<DetailApartmentScreen> {
  ApartmentServices apartmentServices = ApartmentServices();
  DateTime? fromDate;
  DateTime? toDate;

  void bookApartment(int apartmentId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Booking apartment..."),
            ],
          ),
        );
      },
    );
    var result = await apartmentServices.bookApartment(
        context, fromDate.toString(), toDate.toString(), apartmentId);
    Navigator.pop(context);

    if (result) {
      showBookingSuccessfulDialog(context, "assets/success.gif");
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);
    } else {
      showErrorMessage(context,
          "Booking failed.\nPlease contact us at info@abisiniya.com, if facing difficulty to book ride.");
    }
  }

  double calculateTotalAmount(int price) {
    if (fromDate != null && toDate != null) {
      final duration = toDate!.difference(fromDate!);
      final nights = duration.inDays;
      return price * nights.toDouble();
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Apartment apartment =
        ModalRoute.of(context)!.settings.arguments as Apartment;
    final user = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarSecondaryScreen(context, apartment.text),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image
              Container(
                height: 350,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: apartment.images.length > 1
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 350,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                          ),
                          items: apartment.images.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )
                      : apartment.images.length < 1
                          ? Container(
                              width: double.infinity,
                              color: Colors.grey,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Icon(
                                    Icons.image,
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'No pictures available',
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.black.withOpacity(
                                        0.7,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Image.network(
                              apartment.images[0],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: CustomColors.lightPrimaryColor,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Specs and Utilities',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Guest: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${apartment.guest}\n',
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Bathroom: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${apartment.bathroom}\n',
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Bedroom: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${apartment.bedroom}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      color: CustomColors.lightPrimaryColor,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Location',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Address: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${apartment.address}\n\n',
                                  ),
                                  const TextSpan(
                                    text: 'City: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${apartment.location}\n\n',
                                  ),
                                  const TextSpan(
                                    text: 'Country: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: apartment.text,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Booking Details Form
              Card(
                color: CustomColors.lightPrimaryColor,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Details',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'From Date:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        fromDate = selectedDate;
                                        toDate = null; // Reset toDate
                                      });
                                    }
                                  },
                                  child: Text(
                                    fromDate != null
                                        ? fromDate!.toString().split(' ')[0]
                                        : 'Select Date',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'To Date:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (fromDate == null) {
                                      // Check if 'from' date is selected first
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Select 'From' Date"),
                                            content: const Text(
                                                "Please select 'from' date first."),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: fromDate!,
                                        firstDate: fromDate!,
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)),
                                      );
                                      if (selectedDate != null) {
                                        setState(() {
                                          toDate = selectedDate;
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    toDate != null
                                        ? toDate!.toString().split(' ')[0]
                                        : 'Select Date',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Total Amount: \$${calculateTotalAmount(apartment.price)}',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${apartment.price} / night',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(CustomColors.primaryColor)),
                onPressed: () {
                  double totalAmount = calculateTotalAmount(apartment.price);
                  if (totalAmount <= 0) {
                    // If totalAmount is non-positive, either dates are not selected or invalid
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Select Dates"),
                          content: Text(totalAmount == 0
                              ? "Please select both 'from' and 'to' dates."
                              : "Please select a valid date range."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Proceed with booking
                    if (user.user.token.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Alert"),
                            content: const Text("Please log in first."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      bookApartment(apartment.id);
                      setState(() {
                        fromDate = null;
                        toDate = null;
                      });
                    }
                  }
                },
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 20, color: Color(0xfff8fbf1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

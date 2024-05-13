import 'package:abisiniya/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:abisiniya/screens/apartments/apartments.dart';
import 'package:provider/provider.dart';

class DetailApartmentScreen extends StatefulWidget {
  static const String routeName = '/detail-apartment-screen';

  const DetailApartmentScreen({Key? key}) : super(key: key);

  @override
  _DetailApartmentScreenState createState() => _DetailApartmentScreenState();
}

class _DetailApartmentScreenState extends State<DetailApartmentScreen> {
  DateTime? fromDate;
  DateTime? toDate;

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
      appBar: AppBar(
        title: Text(apartment.text),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image
              Container(
                height: 350, // Adjust the height as needed
                padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8), // Adjust the padding as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    apartment.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16), // Added spacing

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Specs and Utilities',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
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
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Location',
                                style: TextStyle(
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
                                    text: '${apartment.text}',
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

              const SizedBox(height: 16), // Added spacing

              // Booking Details Form
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                                      });
                                    }
                                  },
                                  child: Text(
                                    fromDate != null
                                        ? '${fromDate!.toString().split(' ')[0]}'
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
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        toDate = selectedDate;
                                      });
                                    }
                                  },
                                  child: Text(
                                    toDate != null
                                        ? '${toDate!.toString().split(' ')[0]}'
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16), // Added spacing
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
                onPressed: () {
                  if (user.user.token.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Alert"),
                          content: const Text("Please do login first"),
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Success"),
                          content: const Text("Booked Successfully"),
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
                  }
                },
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

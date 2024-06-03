import 'package:abisiniya/screens/apartments/add_apartment.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApartments extends StatefulWidget {
  const MyApartments({super.key});

  @override
  State<MyApartments> createState() => _MyApartmentsState();
}

class _MyApartmentsState extends State<MyApartments> {
  @override
  void initState() {
    super.initState();
    fetchUserApartments();
  }

  void showEditApartmentDialog(Map<String, dynamic> apartment) {
    TextEditingController nameController =
        TextEditingController(text: apartment['name']);
    TextEditingController addressController =
        TextEditingController(text: apartment['address']);
    TextEditingController cityController =
        TextEditingController(text: apartment['city']);
    TextEditingController countryController =
        TextEditingController(text: apartment['country']);
    TextEditingController guestController =
        TextEditingController(text: apartment['guest'].toString());
    TextEditingController bedroomController =
        TextEditingController(text: apartment['bedroom'].toString());
    TextEditingController bathroomController =
        TextEditingController(text: apartment['bathroom'].toString());
    TextEditingController priceController =
        TextEditingController(text: apartment['price'].toString());

    String selectedStatus = "Pending";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Edit Apartment'),
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: addressController,
                        decoration: const InputDecoration(labelText: 'Address'),
                      ),
                      TextField(
                        controller: cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                      ),
                      TextField(
                        controller: countryController,
                        decoration: const InputDecoration(labelText: 'Country'),
                      ),
                      TextField(
                        controller: guestController,
                        decoration: const InputDecoration(labelText: 'Guest'),
                      ),
                      TextField(
                        controller: bedroomController,
                        decoration:
                            const InputDecoration(labelText: 'Bedrooms'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: bathroomController,
                        decoration:
                            const InputDecoration(labelText: 'Bathrooms'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                            value: selectedStatus,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Pending"),
                                value: "Pending",
                              ),
                              DropdownMenuItem(
                                child: Text("Inactive"),
                                value: "Inactive",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value!;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    apartmentServices.updateApartments(
                        context,
                        nameController.text,
                        addressController.text,
                        cityController.text,
                        countryController.text,
                        selectedStatus,
                        int.parse(guestController.text),
                        int.parse(bedroomController.text),
                        int.parse(bathroomController.text),
                        int.parse(priceController.text),
                        apartment['id']);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  ApartmentServices apartmentServices = ApartmentServices();
  List<dynamic> myApartments = [];

  Future<void> fetchUserApartments() async {
    final apartments = await apartmentServices.usersApartment(context);
    if (apartments != null) {
      setState(() {
        myApartments = apartments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Apartments',
              style: GoogleFonts.raleway(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: CustomColors.smokyBlackColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddApartmentForm.routeName);
              },
              child: Text(
                'Add Apartment',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.smokyBlackColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 0,
              childAspectRatio: 0.65,
            ),
            itemCount: myApartments.length,
            itemBuilder: (context, index) {
              var apartment = myApartments[index];
              return Card(
                color: Color(0xffeff1ed),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        apartment['pictures'].isNotEmpty
                            ? ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  apartment['pictures'][0]['imageUrl'],
                                  width: double.infinity,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.image, size: 120),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                apartment['name'],
                                style: GoogleFonts.raleway(
                                  letterSpacing: 1.5,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.smokyBlackColor,
                                ),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                '${apartment['address']},${apartment['country']}',
                                style: GoogleFonts.raleway(
                                  letterSpacing: 2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.bed,
                                      size: 25, color: Colors.black),
                                  Text(
                                    '${apartment['bedroom']}',
                                    style: GoogleFonts.raleway(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.smokyBlackColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(Icons.bathtub,
                                      size: 25, color: Colors.black),
                                  Text(
                                    '${apartment['bathroom']}',
                                    style: GoogleFonts.raleway(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.smokyBlackColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(Icons.person_2,
                                      size: 25, color: Colors.black),
                                  Text(
                                    '${apartment['guest']} ',
                                    style: GoogleFonts.raleway(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.smokyBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showEditApartmentDialog(apartment);
                                    },
                                    child: Image.asset(
                                      height: 30,
                                      width: 30,
                                      'assets/editIicon.png',
                                      fit: BoxFit.cover, // Adjust as needed
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      apartmentServices.deleteApartment(
                                          context, apartment['id']);
                                    },
                                    child: Image.asset(
                                      height: 30,
                                      width: 30,
                                      'assets/deleteIcon.png',
                                      fit: BoxFit.cover, // Adjust as needed
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${apartment['price']}/night',
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

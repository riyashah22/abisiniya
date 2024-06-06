import 'package:abisiniya/constants/error_handling.dart';
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
        var width = MediaQuery.of(context).size.width;
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
                          SizedBox(
                            width: width * 0.07,
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
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 16),
                              Text("Updating Apartment"),
                            ],
                          ),
                        );
                      },
                    );
                    var result = await apartmentServices.updateApartments(
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
                      apartment['id'],
                    );
                    Navigator.pop(context);
                    if (result) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Success"),
                            content: Text(
                                "Apartment Updated Successfully.\nPlease Refresh the screen to view changes."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showErrorMessage(context, "Failed to update apartment.");
                    }
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
  bool isLoading = false;

  Future<void> fetchUserApartments() async {
    setState(() {
      isLoading = true;
    });

    final apartments = await apartmentServices.usersApartment(context);
    if (apartments != null) {
      setState(() {
        myApartments = apartments;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  CustomColors.primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AddApartmentForm.routeName);
              },
              child: Text(
                'Add Apartment',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.lightPrimaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (isLoading)
          Container(
            height: height * 0.6,
            child: Center(
                child: Center(
              child: Image.asset(
                "assets/loading.gif",
                height: 100,
                width: 100,
              ),
            )),
          )
        else
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 0,
                childAspectRatio: 0.62,
              ),
              itemCount: myApartments.length,
              itemBuilder: (context, index) {
                var apartment = myApartments[index];
                return Card(
                  color: Colors.white,
                  elevation: 3,
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
                                    height: height * 0.14,
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
                                  height: height * 0.001,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  apartment['name'],
                                  style: GoogleFonts.roboto(
                                    letterSpacing: 0.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.smokyBlackColor,
                                  ),
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${apartment['address']}, ${apartment['country']}',
                                  style: GoogleFonts.openSans(
                                    letterSpacing: 0.2,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff708090).withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.bed,
                                      size: 22,
                                      color: CustomColors.smokyBlackColor
                                          .withOpacity(0.75),
                                    ),
                                    Text(
                                      '${apartment['bedroom']}',
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.smokyBlackColor
                                            .withOpacity(0.75),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Icon(
                                      Icons.bathtub,
                                      size: 22,
                                      color: CustomColors.smokyBlackColor
                                          .withOpacity(0.75),
                                    ),
                                    Text(
                                      '${apartment['bathroom']}',
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.smokyBlackColor
                                            .withOpacity(0.75),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Icon(
                                      Icons.person_2,
                                      size: 22,
                                      color: CustomColors.smokyBlackColor
                                          .withOpacity(0.75),
                                    ),
                                    Text(
                                      '${apartment['guest']} ',
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.smokyBlackColor
                                            .withOpacity(0.75),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.025),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showEditApartmentDialog(apartment);
                                        fetchUserApartments();
                                      },
                                      child: Image.asset(
                                        height: height * 0.03,
                                        width: width * 0.05,
                                        'assets/editIicon.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              content: Row(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(width: 16),
                                                  Text("Deleting apartment..."),
                                                ],
                                              ),
                                            );
                                          },
                                        );

                                        var result = await apartmentServices
                                            .deleteApartment(
                                                context, apartment['id']);

                                        Navigator.pop(context);

                                        if (result) {
                                          showSuccessMessage(context,
                                              "Apartment Updated Successfully.\nPlease Refresh the screen to view changes.");
                                        } else {
                                          showErrorMessage(
                                              context, "Something went wrong");
                                        }
                                      },
                                      child: Image.asset(
                                        height: height * 0.027,
                                        width: width * 0.045,
                                        'assets/deleteIcon.png',
                                        fit: BoxFit.cover,
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

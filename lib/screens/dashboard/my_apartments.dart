import 'package:abisiniya/screens/apartments/add_apartment.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Apartment'),
          content: SingleChildScrollView(
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
                  decoration: const InputDecoration(labelText: 'Bedrooms'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: bathroomController,
                  decoration: const InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
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
                // Call update apartment service here
                apartmentServices.updateApartments(
                    context,
                    nameController.text,
                    addressController.text,
                    cityController.text,
                    countryController.text,
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
            const Text(
              'My Apartments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddApartmentForm.routeName);
              },
              child: const Text('Add Apartment'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: myApartments.length,
            itemBuilder: (context, index) {
              var apartment = myApartments[index];
              // print(apartment);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: apartment['pictures'].isNotEmpty
                      ? Image.network(apartment['pictures'][0]['imageUrl'],
                          width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image, size: 50),
                  title: Text(apartment['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address: ${apartment['address']}'),
                      Text('City: ${apartment['city']}'),
                      Text('Country: ${apartment['country']}'),
                      Text('Guest: ${apartment['guest']}'),
                      Text('Bedrooms: ${apartment['bedroom']}'),
                      Text('Bathrooms: ${apartment['bathroom']}'),
                      Text('Price: \$${apartment['price']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showEditApartmentDialog(apartment);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          apartmentServices.deleteApartment(
                              context, apartment['id']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

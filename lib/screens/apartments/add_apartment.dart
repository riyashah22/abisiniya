import 'package:abisiniya/models/apartment.dart';
import 'package:abisiniya/services/apartment_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddApartmentForm extends StatefulWidget {
  static const String routeName = '/add-apartment-screen';
  @override
  _AddApartmentFormState createState() => _AddApartmentFormState();
}

class _AddApartmentFormState extends State<AddApartmentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _guestController = TextEditingController();
  final _bedroomController = TextEditingController();
  final _bathroomController = TextEditingController();
  final _priceController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFiles = [];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _guestController.dispose();
    _bedroomController.dispose();
    _bathroomController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void selectImages() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        setState(() {
          imageFiles.addAll(selectedImages);
        });
      }
    } catch (e) {
      print('Error picking images: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

  ApartmentServices apartmentServices = ApartmentServices();

  Future<void> _addApartment() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String address = _addressController.text;
      String city = _cityController.text;
      String country = _countryController.text;
      int guest = int.parse(_guestController.text);
      int bedroom = int.parse(_bedroomController.text);
      int bathroom = int.parse(_bathroomController.text);
      int price = int.parse(_priceController.text);
      List<String> imagePaths = imageFiles.map((e) => '"${e.path}"').toList();

      await apartmentServices.addApartments(
        context,
        name,
        address,
        city,
        country,
        guest,
        bedroom,
        bathroom,
        price,
        imagePaths,
      );

      // print(imagePaths);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Apartment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the country';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _guestController,
                  decoration: InputDecoration(labelText: 'Guest'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of guests';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bedroomController,
                  decoration: InputDecoration(labelText: 'Bedroom'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of bedrooms';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bathroomController,
                  decoration: InputDecoration(labelText: 'Bathroom'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of bathrooms';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectImages,
                  child: Text('Select Images'),
                ),
                SizedBox(height: 20),
                imageFiles.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        children: imageFiles.map((image) {
                          return Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      )
                    : Text('No images selected'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addApartment,
                  child: Text('Add Apartment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

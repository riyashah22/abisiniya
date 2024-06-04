import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:abisiniya/services/apartment_services.dart';

class AddApartmentForm extends StatefulWidget {
  static const String routeName = '/add-apartment-screen';

  const AddApartmentForm({super.key});

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
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _imageFiles = [];

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

  void _selectImages() async {
    try {
      final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        setState(() {
          _imageFiles.addAll(selectedImages);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

  ApartmentServices _apartmentServices = ApartmentServices();

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
      List<File> imageFilesAsFiles =
          _imageFiles.map((e) => File(e.path)).toList();

      await _apartmentServices.addApartments(
        context,
        name,
        address,
        city,
        country,
        guest,
        bedroom,
        bathroom,
        price,
        imageFilesAsFiles,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Apartment'),
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
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the country';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _guestController,
                  decoration: const InputDecoration(labelText: 'Guest'),
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
                  decoration: const InputDecoration(labelText: 'Bedroom'),
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
                  decoration: const InputDecoration(labelText: 'Bathroom'),
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
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _selectImages,
                      child: const Text('Select Images'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _imageFiles.clear()),
                      child: const Text('Clear Images'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _imageFiles.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        children: _imageFiles.map((image) {
                          return Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      )
                    : const Text('No images selected'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addApartment,
                  child: const Text('Add Apartment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

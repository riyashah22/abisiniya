import 'package:abisiniya/constants/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:abisiniya/services/vehicle_services.dart';

class AddVehicleScreen extends StatefulWidget {
  static const String routeName = '/add-vehicle-screen';

  const AddVehicleScreen({super.key});

  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _engineSizeController = TextEditingController();
  final _fuelTypeController = TextEditingController();
  final _weightController = TextEditingController();
  final _colorController = TextEditingController();
  final _transmissionController = TextEditingController();
  final _priceController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _imageFiles = [];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _engineSizeController.dispose();
    _fuelTypeController.dispose();
    _weightController.dispose();
    _colorController.dispose();
    _transmissionController.dispose();
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

  VehicleServices _vehicleServices = VehicleServices();

  Future<void> _addVehicle() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String address = _addressController.text;
      String city = _cityController.text;
      String country = _countryController.text;
      String make = _makeController.text;
      String model = _modelController.text;
      int year = int.parse(_yearController.text);
      int engineSize = int.parse(_engineSizeController.text);
      String fuelType = _fuelTypeController.text;
      int weight = int.parse(_weightController.text);
      String color = _colorController.text;
      String transmission = _transmissionController.text;
      int price = int.parse(_priceController.text);
      List<File> imageFilesAsFiles =
          _imageFiles.map((e) => File(e.path)).toList();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Adding your vehicle..."),
              ],
            ),
          );
        },
      );

      var result = await _vehicleServices.addVehicles(
        context,
        name,
        address,
        city,
        country,
        make,
        model,
        year,
        engineSize,
        fuelType,
        weight,
        color,
        transmission,
        price,
        imageFilesAsFiles,
      );

      Navigator.pop(context);

      if (result) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Vehicle added successfully."),
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
        showErrorMessage(context, "Failed to add vehicle");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
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
                  controller: _makeController,
                  decoration: const InputDecoration(labelText: 'Make'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the make';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the model';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the year';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _engineSizeController,
                  decoration: const InputDecoration(labelText: 'Engine Size'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the engine size';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _fuelTypeController,
                  decoration: const InputDecoration(labelText: 'Fuel Type'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the fuel type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the color';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _transmissionController,
                  decoration: const InputDecoration(labelText: 'Transmission'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the transmission';
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
                  onPressed: _addVehicle,
                  child: const Text('Add Vehicle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

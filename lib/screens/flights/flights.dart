import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/flight_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({Key? key}) : super(key: key);

  @override
  _FlightScreenState createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoggedIn = false;

  String _from = 'New York';
  String _to = 'Los Angeles';

  String _class = 'Economy';
  String _tripType = 'One Way';
  DateTime? _departureDate;
  DateTime? _returnDate;
  String _message = '';

  FlightServices flightServices = FlightServices();
  List<String> airlines = [];
  String? _airline;

  @override
  void initState() {
    super.initState();
    getAirlines();
  }

  Future<void> getAirlines() async {
    List<String> fetchAirlines = await flightServices.airlines(context);
    setState(() {
      airlines = fetchAirlines;
    });
  }

  final List<String> _locations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston'
  ];

  final List<String> _classes = ['Economy', 'Business', 'First Class'];
  final List<String> _tripTypes = ['One Way', 'Round Trip', 'Multi-City'];

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('Please log in first.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
          if (_returnDate != null && _departureDate!.isAfter(_returnDate!)) {
            _showValidationDialog('Departure date cannot be after return date');
            _returnDate = null; // Clear return date if it conflicts
          }
        } else {
          if (_departureDate != null && picked.isBefore(_departureDate!)) {
            _showValidationDialog(
                'Return date cannot be before departure date');
          } else {
            _returnDate = picked;
          }
        }
      });
    }
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Date Selection'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_tripType == 'Round Trip' &&
          (_departureDate == null || _returnDate == null)) {
        _showValidationDialog(
            'Both departure and return dates are required for round trips');
        return;
      }

      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Flight Request',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _from, // Set initial value
                decoration: const InputDecoration(labelText: 'From'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a departure location';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _from = newValue;
                  });
                },
              ),
              TextFormField(
                initialValue: _to, // Set initial value
                decoration: const InputDecoration(labelText: 'To'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination location';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    _to = newValue;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _airline,
                decoration:
                    const InputDecoration(labelText: 'Airline Preferences'),
                items: airlines.map((String airline) {
                  return DropdownMenuItem<String>(
                    value: airline,
                    child: Text(airline),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _airline = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _class,
                decoration: const InputDecoration(labelText: 'Travel Class'),
                items: _classes.map((String travelClass) {
                  return DropdownMenuItem<String>(
                    value: travelClass,
                    child: Text(travelClass),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _class = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _tripType,
                decoration: const InputDecoration(labelText: 'Trip Type'),
                items: _tripTypes.map((String tripType) {
                  return DropdownMenuItem<String>(
                    value: tripType,
                    child: Text(tripType),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tripType = newValue!;
                  });
                },
              ),
              ListTile(
                title: Text(
                    'Departure Date: ${_departureDate?.toLocal().toString().split(' ')[0] ?? 'Select Date'}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              ListTile(
                title: Text(
                    'Return Date: ${_returnDate?.toLocal().toString().split(' ')[0] ?? 'Select Date'}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 3,
                onChanged: (newValue) {
                  setState(() {
                    _message = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ));
  }
}

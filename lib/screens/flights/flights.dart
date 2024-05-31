import 'package:abisiniya/constants/error_handling.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/screens/auth/login.dart';
import 'package:abisiniya/services/flight_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  final _formKey = GlobalKey<FormState>();
  final FlightServices flightServices = FlightServices();

  String _from = '';
  String _to = '';
  String? _airline;
  String _class = 'Economy';
  String _tripType = 'One Way';
  DateTime? fromDate;
  DateTime? toDate;
  String _message = '';

  List<String> _airports = [];
  List<String> _airlines = [];

  final List<String> _classes = ['Economy', 'Business', 'First Class'];
  final List<String> _tripTypes = ['One Way', 'Round Trip', 'Multi-City'];

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

  void _submitForm() async {
    final user = Provider.of<UserProvider>(context, listen: false);
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
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: const Text("Login"),
              ),
            ],
          );
        },
      );
      showSnackBar(context, "Please login");
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        if (_tripType == 'Round Trip' && (fromDate == null || toDate == null)) {
          _showValidationDialog(
              'Both departure and return dates are required for round trips');
          return;
        }

        await flightServices.flightRequest(
            context,
            _from,
            _to,
            fromDate.toString(),
            toDate?.toString() ?? '',
            _airline!,
            _class,
            _tripType,
            _message);
      }
    }
  }

  Future<void> _getAirports() async {
    _airports = await flightServices.airports(context);
    setState(() {});
  }

  Future<void> _getAirlines() async {
    _airlines = await flightServices.airlines(context);
    setState(() {});
  }

  @override
  void initState() {
    _getAirports();
    _getAirlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
                _buildAutocomplete(
                  labelText: 'From',
                  options: _airports,
                  onSelected: (selection) {
                    setState(() {
                      _from = selection;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildAutocomplete(
                  labelText: 'To',
                  options: _airports,
                  onSelected: (selection) {
                    setState(() {
                      _to = selection;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildAutocomplete(
                  labelText: 'Airline Preferences',
                  options: _airlines,
                  onSelected: (selection) {
                    setState(() {
                      _airline = selection;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  labelText: 'Travel Class',
                  value: _class,
                  items: _classes,
                  onChanged: (newValue) {
                    setState(() {
                      _class = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  labelText: 'Trip Type',
                  value: _tripType,
                  items: _tripTypes,
                  onChanged: (newValue) {
                    setState(() {
                      _tripType = newValue!;
                      if (_tripType == 'One Way') {
                        toDate = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildDateSelection(
                  enabled: true,
                  context,
                  label: 'From Date:',
                  date: fromDate,
                  onSelectDate: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        fromDate = selectedDate;
                        toDate = null; // Reset toDate
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                _buildDateSelection(
                  context,
                  label: 'To Date:',
                  date: toDate,
                  onSelectDate: () async {
                    if (fromDate == null) {
                      _showValidationDialog("Please select 'From' date first.");
                    } else {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: fromDate!,
                        firstDate: fromDate!,
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          toDate = selectedDate;
                        });
                      }
                    }
                  },
                  enabled: _tripType != 'One Way',
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: InputBorder.none,
                      ),
                      maxLines: 2,
                      onChanged: (newValue) {
                        setState(() {
                          _message = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAutocomplete({
    required String labelText,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return options.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            onSelected(selection);
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: labelText,
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a $labelText';
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String labelText,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDateSelection(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required Function() onSelectDate,
    required bool enabled, // Added parameter for enabling/disabling the field
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(
          '$label ${date != null ? date.toString().split(' ')[0] : 'Select Date'}',
        ),
        trailing: const Icon(Icons.calendar_today),
        onTap: enabled ? onSelectDate : null, // Disable onTap when not enabled
      ),
    );
  }
}

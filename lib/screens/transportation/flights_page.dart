import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/transportation_provider.dart';

class FlightsPage extends StatefulWidget {
  const FlightsPage({Key? key}) : super(key: key);

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  String _departure = '';
  String _arrival = '';
  DateTime? _selectedDate;
  int _numberOfPeople = 1;

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<TransportationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Flights'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Departure',
            ),
            onChanged: (value) {
              setState(() {
                _departure = value;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Arrival',
            ),
            onChanged: (value) {
              setState(() {
                _arrival = value;
              });
            },
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date',
              ),
              child: Text(
                _selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                    : 'Select date',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Number of people:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: _numberOfPeople,
                onChanged: (value) {
                  setState(() {
                    _numberOfPeople = value!;
                  });
                },
                items: List.generate(10, (index) => index + 1)
                    .map((int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              flightProvider.searchTransportation(
                _selectedDate!,
                _departure,
                _arrival,
                _numberOfPeople,
              );
              Navigator.pushNamed(context, '/flight_list');
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}

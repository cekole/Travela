import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/transportation_provider.dart';

class FlightsPage extends StatefulWidget {
  const FlightsPage({Key? key}) : super(key: key);

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  DateTime _currentStartDateCheckIn = DateTime.now();
  DateTime _currentEndDateCheckIn = DateTime.now().add(const Duration(days: 7));
  DateTime _currentStartDateCheckOut = DateTime.now();
  DateTime _currentEndDateCheckOut =
      DateTime.now().add(const Duration(days: 7));
  int _numberOfPeople = 1;

  String originCode = '';
  String destinationCode = '';

  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  DateTime rangeStartDate = DateTime.now();
  DateTime rangeEndDate = DateTime.now().add(const Duration(days: 7));

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
    if (args.value is PickerDateRange) {
      setState(() {
        rangeStartDate = args.value.startDate;
        rangeEndDate = args.value.endDate;
      });
    } else if (args.value is DateTime) {
      setState(() {
        rangeStartDate = args.value;
        rangeEndDate = args.value;
      });
    }
  }

  @override
  void initState() {
    currentTransportations = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Flights'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //container textfield style
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              title: Text(
                'Departure',
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy').format(_currentStartDateCheckIn),
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                          Text(
                            'Select Departure Date',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          SfDateRangePicker(
                            controller: _dateRangePickerController,
                            headerStyle: DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                            ),
                            enablePastDates: false,
                            onSelectionChanged: _onSelectionChanged,
                            selectionMode: DateRangePickerSelectionMode.single,
                            initialDisplayDate: DateTime.now(),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _currentStartDateCheckIn = rangeStartDate;
                                    _currentEndDateCheckIn = rangeEndDate;
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text('Done'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              title: Text('From'),
              subtitle: Text(originCode),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'Select City',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(),
                          for (var destination
                              in Provider.of<DestinationsProvider>(context,
                                      listen: false)
                                  .destinations)
                            ListTile(
                              title: Text(destination.city),
                              subtitle: Text(destination.country),
                              onTap: () {
                                setState(() {
                                  originCode = destination.cityIataCode;
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              title: Text('Number of people'),
              trailing: DropdownButton<int>(
                borderRadius: BorderRadius.circular(10),
                value: _numberOfPeople,
                onChanged: (int? newValue) {
                  setState(() {
                    _numberOfPeople = newValue!;
                  });
                },
                items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final transportationData =
                  Provider.of<TransportationProvider>(context, listen: false);
              transportationData
                  .searchTransportation(
                _currentStartDateCheckIn.toString().split(' ')[0],
                originCode,
                'ESB',
                _numberOfPeople,
              )
                  .then((value) {
                //Navigator.of(context).pushNamed('/flight_list');
              });
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}

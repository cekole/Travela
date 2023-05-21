import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/accomodation_provider.dart';
import 'package:travela_mobile/providers/trip_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  DateTime _currentStartDateCheckIn = DateTime.now();
  DateTime _currentEndDateCheckIn = DateTime.now().add(const Duration(days: 7));
  DateTime _currentStartDateCheckOut = DateTime.now();
  DateTime _currentEndDateCheckOut =
      DateTime.now().add(const Duration(days: 7));
  var numberOfPeople = 1;

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
    super.initState();
    currentAccomodations = [];
  }

  @override
  Widget build(BuildContext context) {
    final destinationFull =
        ModalRoute.of(context)!.settings.arguments as Destination;
    final destination = destinationFull.city;
    final city = destination;
    print(city);

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Accommodation'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                //Check in date select button opens a dialog
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    title: Text(
                      'Check in',
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(_currentStartDateCheckIn),
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.calendar_today,
                      color: Colors.grey[600],
                    ),
                    onTap: () async {
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
                                  'Select your check in date',
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
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  initialDisplayDate: DateTime.now(),
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentStartDateCheckIn =
                                              rangeStartDate;
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
                    title: Text(
                      'Check out',
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy')
                          .format(_currentStartDateCheckOut),
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.calendar_today,
                      color: Colors.grey[600],
                    ),
                    onTap: () async {
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
                                  'Select your check out date',
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
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  initialDisplayDate: DateTime.now(),
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentStartDateCheckOut =
                                              rangeStartDate;
                                          _currentEndDateCheckOut =
                                              rangeEndDate;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Submit'),
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
                    title: Text(
                      'Number of people',
                    ),
                    subtitle: Text(
                      '$numberOfPeople people',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: DropdownButton<int>(
                      borderRadius: BorderRadius.circular(10),
                      value: numberOfPeople,
                      onChanged: (int? newValue) {
                        setState(() {
                          numberOfPeople = newValue!;
                        });
                      },
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              final accomodationData =
                  Provider.of<AccomodationProvider>(context, listen: false);

              accomodationData
                  .searchAccomodation(
                city.toLowerCase(),
                _currentEndDateCheckIn.toString().split(' ')[0],
                _currentEndDateCheckOut.toString().split(' ')[0],
                numberOfPeople,
              )
                  .then((value) {
                Navigator.of(context).pushNamed(
                  '/accomodation_list',
                  arguments: destinationFull,
                );
              });
            },
            child: Text(
              'Search',
            ),
          ),
        ],
      ),
    );
  }
}

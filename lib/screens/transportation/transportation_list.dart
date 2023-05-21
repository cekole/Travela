import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/transportation_provider.dart';

class TransportationList extends StatefulWidget {
  @override
  _TransportationListState createState() => _TransportationListState();
}

class _TransportationListState extends State<TransportationList> {
  int selectedIndex = -1;

  void _selectContainer(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _submitSelection(
    String originCityIataCode,
    String destinationCityIataCode,
    String price,
    String duration,
  ) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final originCityName = args[1] as String;
    final destinationCityName = args[2] as String;

    final durationInMinutes = int.parse(duration.substring(2, 3)) * 60 +
        int.parse(duration.substring(5, 6));

    final destinationData =
        Provider.of<DestinationsProvider>(context, listen: false);
    print(originCityName);
    print(destinationCityName);
    for (final destination in destinationData.destinations) {
      if (destination.city == originCityName) print('org' + destination.city);
      if (destination.city == destinationCityName)
        print('dest' + destination.city);
    }
    final originIata = destinationData.destinations.firstWhere(
      (element) => element.city == originCityName,
    );
    final destinationIata = destinationData.destinations.firstWhere(
      (element) => element.city == destinationCityName,
    );
    final now = DateTime.now().toUtc();
    final formattedDateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(now);
    print(originIata.id);
    print(destinationIata.id);
    print('PLANE');
    print('No link');
    print(price);
    print(formattedDateTime);
    print(durationInMinutes);
    print(currentTripId);

    final transportationData =
        Provider.of<TransportationProvider>(context, listen: false);
    transportationData
        .addTransportation(
      originIata.id,
      destinationIata.id,
      'PLANE',
      'No link',
      double.parse(price),
      formattedDateTime,
      double.parse(durationInMinutes.toString()),
      currentTripId,
    )
        .then((value) {
      if (value != null) {
        Platform.isIOS
            ? showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      title: const Text('Success'),
                      content: Text(
                          'Transportation from ${originCityName} to ${destinationCityName} added successfully'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ))
            : showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Success'),
                  content: Text(
                      'Transportation from ${originCityName} to ${destinationCityName} added successfully'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: selectedIndex != -1,
        child: ElevatedButton(
          onPressed: selectedIndex != -1
              ? () => _submitSelection(
                    currentTransportations[0][2] as String,
                    currentTransportations[0][3] as String,
                    currentTransportations[selectedIndex][1] as String,
                    currentTransportations[selectedIndex][0] as String,
                  )
              : null,
          child: const Text('Submit'),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            currentTransportations = [];
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('Transportation'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: currentTransportations.length,
        itemBuilder: (context, index) {
          final duration = currentTransportations[index][0] as String;
          final price = currentTransportations[index][1] as String;
          final departure = currentTransportations[index][2] as String;
          final arrival = currentTransportations[index][3] as String;
          final segments = currentTransportations[index][4] as List;

          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: GestureDetector(
              onTap: () {
                _selectContainer(index);
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: selectedIndex == index
                      ? Theme.of(context).primaryColor.withOpacity(0.2)
                      : Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    'Total Duration: ${duration.substring(2, 3)} Hours ${duration.substring(5, 6)} Minutes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price: €$price',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Departure: $departure',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Arrival: $arrival',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      segments.length > 1
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < segments.length; i++)
                                    ListTile(
                                      title: Text(
                                        'Segment ${i + 1}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Departure: ${segments[i]['departure']}',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            'Arrival: ${segments[i]['arrival']}',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Text(
                              'Stops: 0',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

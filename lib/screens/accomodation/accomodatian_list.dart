import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/accomodation_provider.dart';
import 'package:travela_mobile/providers/trip_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class AccommodationList extends StatefulWidget {
  const AccommodationList({Key? key}) : super(key: key);

  @override
  _AccommodationListState createState() => _AccommodationListState();
}

class _AccommodationListState extends State<AccommodationList> {
  int selectedIndex = -1;
  String locationId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accommodation'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: Visibility(
        visible: selectedIndex != -1,
        child: ElevatedButton(
          onPressed: selectedIndex != -1 ? () => _submitSelection() : null,
          child: const Text('Submit'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentAccomodations.length,
              itemBuilder: (context, index) {
                final price = currentAccomodations[index][1] as String;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(3.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            currentAccomodations[index][2],
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                currentAccomodations[index][0] +
                                    ', ' +
                                    price.substring(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _submitSelection() async {
    final tripData = Provider.of<TripProvider>(context, listen: false);
    final locations = await tripData.getLocationsByTripId(currentTripId);
    locationId = locations[0]['location_id'].toString();
    final accommodationData =
        Provider.of<AccomodationProvider>(context, listen: false);
    accommodationData.addAccomodation(
      {
        "name": currentAccomodations[selectedIndex][0],
        "price": currentAccomodations[selectedIndex][1],
        "link": "",
        "address": "",
        "description": "",
        "type": "",
        "rating": "0",
        "image": currentAccomodations[selectedIndex][2],
        "location_id": locationId,
      },
    ).then(
      (value) {
        if (value != null) {
          //show dialog success
          Platform.isIOS
              ? showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Success'),
                    content: Text('Accomodation added successfully'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Success'),
                    content: Text('Accomodation added successfully'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
        }
      },
    );
  }
}

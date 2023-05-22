import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/accomodation.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/accomodation_provider.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/providers/trip_provider.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/screens/home/popular_destinations.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';
import 'package:travela_mobile/widgets/group/suggestionsForGroup.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _groupNameController = TextEditingController();
    TextEditingController _groupDescriptionController = TextEditingController();
    TextEditingController _groupDestinationController = TextEditingController();
    TextEditingController _groupPeriodController = TextEditingController();

    final userData = Provider.of<UserProvider>(context, listen: false);
    userData.getUpcomingTrips(userId);
    userData.getPreviousTrips(userId);

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Trips'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _travelGroupModal(context);
        },
        label: Text('Arrange Trips'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              //Upcoming Trips header
              Text(
                'Upcoming Trips',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  itemCount: userData.upcomingTrips.length,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> locations = [];
                    List<Accomodation> accomodationForLocation = [];

                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onTap: () {
                        final trip = userData.upcomingTrips[index];
                        Destination? startDestination;
                        Destination? endDestination;
                        final tripData =
                            Provider.of<TripProvider>(context, listen: false);
                        final destinationData =
                            Provider.of<DestinationsProvider>(context,
                                listen: false);
                        tripData.getLocationsByTripId(trip.id).then(
                          (value) {
                            locations = value;
                            tripData.getTransportations(trip.id);
                            final accomodationData =
                                Provider.of<AccomodationProvider>(context,
                                    listen: false);
                            final accomodationList = accomodationData
                                .fetchAllAccomodations()
                                .then((value) {
                              if (value.isNotEmpty) {
                                accomodationForLocation = value
                                    .where((element) =>
                                        element.location['location_id'] ==
                                        locations[0]['location_id'])
                                    .toList();
                              }

                              if (tripData.transportations.isNotEmpty) {
                                startDestination =
                                    destinationData.destinations.firstWhere(
                                  (element) =>
                                      element.id ==
                                      tripData.transportations[0].startCityId,
                                );

                                endDestination = destinationData.destinations
                                    .firstWhere((element) =>
                                        element.id ==
                                        tripData.transportations[0].endCityId);
                              }
                            }).then(
                              (value) {
                                tripData.transportations.forEach((element) {});
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: ListView(
                                        children: [
                                          //locations
                                          Column(
                                            children: [
                                              Card(
                                                elevation: 20,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text('Locations'),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      child: locations.isEmpty
                                                          ? Center(
                                                              child: Text(
                                                                  'No locations are added'),
                                                            )
                                                          : ListView.builder(
                                                              itemCount:
                                                                  locations
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return ListTile(
                                                                  leading: Icon(
                                                                    Icons
                                                                        .pin_drop,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  title: Text(locations[
                                                                          index]
                                                                      [
                                                                      'locationName']),
                                                                );
                                                              },
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Card(
                                                elevation: 20,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title:
                                                          Text('Accomodations'),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      child:
                                                          accomodationForLocation
                                                                  .isEmpty
                                                              ? Center(
                                                                  child: Text(
                                                                      'No accommodations are added yet'),
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                  itemCount:
                                                                      accomodationForLocation
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return ListTile(
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .hotel,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                      title: Text(
                                                                          accomodationForLocation[index]
                                                                              .name),
                                                                      subtitle:
                                                                          Text(
                                                                        accomodationForLocation[index]
                                                                            .price
                                                                            .substring(3),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Card(
                                                elevation: 20,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                          'Transportations'),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                    ),
                                                    Container(
                                                      height: 200,
                                                      child: tripData
                                                              .transportations
                                                              .isEmpty
                                                          ? Center(
                                                              child: Text(
                                                                  'No transportaition is added yet'),
                                                            )
                                                          : ListView.builder(
                                                              itemCount: tripData
                                                                  .transportations
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return ListTile(
                                                                  leading: Icon(
                                                                    Icons
                                                                        .flight,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  title: Text(
                                                                    startDestination!
                                                                            .city +
                                                                        ' to ' +
                                                                        endDestination!
                                                                            .city,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    '€' +
                                                                        tripData
                                                                            .transportations[index]
                                                                            .price
                                                                            .toString(),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                      leading: Icon(
                        Icons.flight_takeoff,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(userData.upcomingTrips[index].name),
                      subtitle: Text(
                        userData.upcomingTrips[index].travelGroup.toString(),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                'Previous Trips',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _travelGroupModal(BuildContext context) {
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Text(
                'Choose a Travel Group',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    final travelGroup = groupData.groups[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      child: ListTile(
                        onTap: () {
                          final groupData = Provider.of<GroupProvider>(context,
                              listen: false);
                          groupData.getParticipants(travelGroup.id);
                          Navigator.of(context).pushNamed(
                            '/edit_travel_group',
                            arguments: travelGroup,
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(travelGroup.groupName),
                        subtitle: Text(
                          travelGroup.commonStartDate.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                  itemCount: groupData.groups.length,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.grey.shade700,
                    indent: 35,
                    endIndent: 35,
                    thickness: 1,
                  )),
                  Text("OR"),
                  Expanded(
                      child: Divider(
                    color: Colors.grey.shade700,
                    indent: 35,
                    endIndent: 35,
                    thickness: 1,
                  )),
                ],
              ),
              TextButton(
                onPressed: () async {
                  await formGroup(context);
                  searchDialog(context);
                },
                child: Text(
                  'Arrange an Individual Trip',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future formGroup(BuildContext context) {
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    final TextEditingController textController = TextEditingController();
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Form Travel Group',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  String groupName = textController.text;
                  if (groupName.isEmpty) {
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? CupertinoAlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter a group name'),
                            actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ])
                        : AlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter a group name'),
                            actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ]);
                  } else {
                    groupData
                        .addGroup(
                      groupName,
                      userId,
                    )
                        .then((value) {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? CupertinoAlertDialog(
                                    title: Text('Success'),
                                    content: Text('Group created successfully'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                : AlertDialog(
                                    title: Text('Success'),
                                    content: Text('Group created successfully'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                      );
                    });
                  }
                },
                child: Text('Create Group'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> searchDialog(BuildContext context) {
  TextEditingController _searchController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) => Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Dialog.fullscreen(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter a place name',
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                Navigator.of(context).pushNamed('/destination_list');
              },
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SuggestionsForGroup(
                isArranged: true,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopularPlaces(
                isArranged: true,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

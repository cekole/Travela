import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
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
    userData.getPastTrips(userId);

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
        label: Text('Arrange Trip'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Trips',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  ExpansionTileCard(
                    baseColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    expandedColor: Theme.of(context).backgroundColor,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: Icon(Icons.directions_boat),
                    ),
                    title: Text(upcomingTrips.length > 0
                        ? upcomingTrips[0].name
                        : 'Italy Trip'),
                    subtitle: upcomingTrips.length > 0
                        ? Text(upcomingTrips[0].period)
                        : Text(''),
                    children: [
                      Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Locations'),
                        subtitle: upcomingTrips.length > 0
                            ? Text(
                                upcomingTrips.map((e) => e.locations).join(','))
                            : Text(''),
                        leading: Icon(Icons.location_on),
                      ),
                      ListTile(
                        title: Text('Travelers'),
                        subtitle: Text(upcomingTrips.length > 0
                            ? upcomingTrips.map((e) => e.travelGroup).join(',')
                            : ''),
                        leading: Icon(Icons.people),
                      ),
                      ListTile(
                        title: Text('Transportation'),
                        subtitle: Text(upcomingTrips.length > 0
                            ? upcomingTrips
                                .map((e) => e.transportation)
                                .join(',')
                            : ''),
                        leading: Icon(Icons.mode_of_travel_sharp),
                      ),
                      ListTile(
                        title: Text('Accomodation'),
                        subtitle: upcomingTrips.length > 0
                            ? Text(upcomingTrips
                                .map((e) => e.accomodation)
                                .join(','))
                            : Text(''),
                        leading: Icon(Icons.hotel),
                      ),
                      ListTile(
                        title: Text('Description'),
                        subtitle: upcomingTrips.length > 0
                            ? Text(upcomingTrips
                                .map((e) => e.description)
                                .join(','))
                            : Text(''),
                        leading: Icon(Icons.note),
                      ),
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            // create a modal to change the trip info
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                height: 300,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Edit Trip Info',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Trip Name',
                                      ),
                                      onChanged: (value) {
                                        _groupNameController.text = value;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Trip Description',
                                      ),
                                      onChanged: (value) {
                                        _groupDescriptionController.text =
                                            value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final tripData =
                                            Provider.of<TripProvider>(context,
                                                listen: false);
                                        tripData.updateTrip(
                                            currentTripId, // buraya trip id gelecek bu çalışmaz şu an
                                            _groupNameController.text,
                                            _groupDescriptionController.text,
                                            currentGroupId);
                                      },
                                      child: Text('Update Trip'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final tripData =
                                            Provider.of<TripProvider>(context,
                                                listen: false);
                                        tripData.deleteTrip(currentTripId);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Delete Trip',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Previous Trips',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PreviousTripsMap(),
                            ),
                          );
                        },
                        icon: Icon(Icons.travel_explore),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  ExpansionTileCard(
                    baseColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    expandedColor: Theme.of(context).backgroundColor,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: Icon(Icons.directions_car),
                    ),
                    title: // çağla ekleyecek
                        Text("Trip To Greece"),
                    subtitle: pastTrips.length > 0
                        ? Text(pastTrips[0].period)
                        : Text(''),
                    children: [
                      Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Locations'),
                        subtitle: pastTrips.length > 0
                            ? Text(pastTrips.map((e) => e.locations).join(','))
                            : Text(''),
                        leading: Icon(Icons.location_on),
                      ),
                      ListTile(
                        title: Text('Travelers'),
                        subtitle: Text(
                            'You, Yağmur Eryılmaz, Efe Şaman, Çağla Ataoğlu, Efe Ertürk'),
                        leading: Icon(Icons.people),
                      ),
                      ListTile(
                        title: Text('Transportation'),
                        subtitle: Text(
                            'Car \n8/20/2021 12:00 PM - 8/24/2021 12:00 PM'),
                        leading: Icon(Icons.mode_of_travel_sharp),
                      ),
                      ListTile(
                        title: Text('Accomodation'),
                        subtitle: pastTrips.length > 0
                            ? Text(
                                pastTrips.map((e) => e.accomodation).join(','))
                            : Text(''),
                        leading: Icon(Icons.hotel),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
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
                    Platform.isIOS
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
                        builder: (context) => Platform.isIOS
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
            /* Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text('Price Range'),
                              Expanded(
                                child: RangeSlider(
                                  activeColor: Theme.of(context).primaryColor,
                                  values: _currentPriceRangeValues,
                                  max: 100,
                                  labels: RangeLabels(
                                    _currentPriceRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentPriceRangeValues.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (values) {
                                    setState(() {
                                      _currentPriceRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentPriceRangeValues.start
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Min'),
                                    ],
                                  ),
                                  VerticalDivider(),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentPriceRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Max'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text('Distance(km)'),
                              Expanded(
                                child: RangeSlider(
                                  activeColor: Theme.of(context).primaryColor,
                                  values: _currentDistanceRangeValues,
                                  max: 1000,
                                  labels: RangeLabels(
                                    _currentDistanceRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentDistanceRangeValues.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (values) {
                                    setState(() {
                                      _currentDistanceRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentDistanceRangeValues.start
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Min'),
                                    ],
                                  ),
                                  VerticalDivider(),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentDistanceRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Max'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ), 
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Apply'),
              ),
              */
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

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/screens/home/popular_destinations.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Trips',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                    title: Text("buraya çağlaekleyince gelecek"),
                    //upcomingTrips.length > 0
                    //? Text(upcomingTrips[0].name)
                    //: Text('No Upcoming Trips'),
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
                        subtitle: Text('You, John Wayne, Emma Watson'),
                        leading: Icon(Icons.people),
                      ),
                      ListTile(
                        title: Text('Transportation'),
                        subtitle: Text(
                            'Ferry \n7/13/2023 12:00 PM - 7/20/2023 12:00 PM'),
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
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Previous Trips',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        Text("buraya çağlaekleyince gelecek"),
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
                onPressed: () {
                  formGroup(context);
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

  void formGroup(BuildContext context) {
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    final TextEditingController textController = TextEditingController();
    showModalBottomSheet(
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
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text('Error'),
                      content: Text('Group name cannot be empty'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  } else {
                    groupData
                        .addGroup(
                      groupName,
                      userId,
                    )
                        .then((value) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text('Success'),
                          content: Text('Group created successfully'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
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

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
        label: Text('Upcoming Trips'),
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
                  for (var trip in userData.upcomingTrips)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ExpansionTileCard(
                        baseColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        expandedColor: Theme.of(context).backgroundColor,
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: Icon(
                            Icons.flight,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        title: Text(trip.name),
                        subtitle: Text(trip.status),
                        children: [
                          Divider(
                            thickness: 1.0,
                            height: 1.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                trip.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  for (var trip in userData.previousTrips)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ExpansionTileCard(
                        baseColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        expandedColor: Theme.of(context).backgroundColor,
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: Icon(
                            Icons.flight,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        title: Text(trip.name),
                        subtitle: Text(trip.status),
                        children: [
                          Divider(
                            thickness: 1.0,
                            height: 1.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                trip.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    CupertinoAlertDialog(
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
                        builder: (context) => CupertinoAlertDialog(
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

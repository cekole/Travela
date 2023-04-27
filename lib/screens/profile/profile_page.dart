import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/screens/trips/trips_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: SizedBox(),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cenk Duran',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Ankara, Turkey',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/edit_profile');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '12',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Friends',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '4',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Trips',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '7',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Places',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Travela',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                ),
                title: Text('Location'),
              ),
              Divider(
                height: 1,
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                ),
                title: Text('Notification'),
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.privacy_tip,
                ),
                title: Text('Privacy'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(
                  Icons.policy,
                ),
                title: Text('Legal & Policies'),
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                ),
                title: Text('Preferences'),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  'Resources',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.support),
                title: Text('Support'),
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void formGroup(BuildContext context) {
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
              ListTile(
                title: Text('Add Members'),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text('Invite Members'),
                            content: ListView(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter username',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Send Invite'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

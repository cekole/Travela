import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          formGroup(context);
        },
        child: Text(
          'Form Group',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('Trips'),
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
                    title: Text('Greek Islands'),
                    subtitle: Text('July 13 - 20, 2023'),
                    children: [
                      Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Locations'),
                        subtitle: Text('Mykonos, Santorini, Crete'),
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
                        subtitle: Text('Ferry Cabin'),
                        leading: Icon(Icons.hotel),
                      ),
                      ListTile(
                        title: Text('Quick Notes'),
                        subtitle: Text('Bring sunscreen, bathing suit, etc.'),
                        leading: Icon(Icons.note),
                      ),
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTileCard(
                    baseColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    expandedColor: Theme.of(context).backgroundColor,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: Icon(Icons.flight),
                    ),
                    title: Text('Aurora Borealis'),
                    subtitle: Text('March 13 - 20, 2023'),
                    children: [
                      Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Locations'),
                        subtitle: Text('Iceland'),
                        leading: Icon(Icons.location_on),
                      ),
                      ListTile(
                        title: Text('Travelers'),
                        subtitle: Text('You, Wayne Gretzky, Emily Blunt'),
                        leading: Icon(Icons.people),
                      ),
                      ListTile(
                        title: Text('Transportation'),
                        subtitle: Text(
                            'Plane \n3/13/2023 12:00 PM - 3/20/2023 12:00 PM'),
                        leading: Icon(Icons.mode_of_travel_sharp),
                      ),
                      ListTile(
                        title: Text('Accomodation'),
                        subtitle: Text('Igloo Hotel'),
                        leading: Icon(Icons.hotel),
                      ),
                      ListTile(
                        title: Text('Quick Notes'),
                        subtitle: Text('Bring sunscreen, bathing suit, etc.'),
                        leading: Icon(Icons.note),
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
                    title: Text('Paris Road Trip'),
                    subtitle: Text('August 20 - 24, 2021'),
                    children: [
                      Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Locations'),
                        subtitle: Text('Paris, Versailles, Giverny'),
                        leading: Icon(Icons.location_on),
                      ),
                      ListTile(
                        title: Text('Parisiens'),
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
                        subtitle: Text('Hotel'),
                        leading: Icon(Icons.hotel),
                      ),
                      ListTile(
                        title: Text('Quick Notes'),
                        subtitle: Text('Don\'t forget to bring your camera !'),
                        leading: Icon(Icons.note),
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
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter username',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ExpansionTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  title: Text('Friends'),
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                                            ),
                                            title: Text('Yağmur Eryılmaz'),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                                            ),
                                            title: Text('Efe Şaman'),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                                            ),
                                            title: Text('Çağla Ataoğlu'),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                                            ),
                                            title: Text('Efe Ertürk'),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
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

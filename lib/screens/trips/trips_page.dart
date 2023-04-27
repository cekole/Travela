import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/screens/home/popular_destinations.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Future<dynamic> _travelGroupModal(BuildContext context) {
    final travelGroupData =
        Provider.of<TravelGroupProvider>(context, listen: false);
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
                    final travelGroup = travelGroupData.travelGroups[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/edit_travel_group',
                            arguments: travelGroup,
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(travelGroup.name),
                        subtitle: Text(
                          travelGroup.destinations
                              .map((destination) =>
                                  '${destination.city}, ${destination.country}')
                              .join(' | '),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                  itemCount: travelGroupData.travelGroups.length,
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
                  Navigator.of(context).pushNamed('/create_travel_group');
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
}

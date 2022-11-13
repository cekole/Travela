import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      IconButton(
                        onPressed: () {},
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
                        title: Text('Quick Notes'),
                        subtitle: Text('Bring sunscreen, bathing suit, etc.'),
                        leading: Icon(Icons.note),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
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
                        onPressed: () {},
                        icon: Icon(Icons.history),
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
}

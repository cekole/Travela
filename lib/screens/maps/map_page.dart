import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/plugin_api.dart';

import 'package:travela_mobile/screens/friends/friends_page.dart';
import 'package:travela_mobile/screens/maps/discovery_map.dart';
import 'package:travela_mobile/screens/maps/friends_map.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';
import 'package:travela_mobile/widgets/maps/discovery_map_body.dart';
import 'package:travela_mobile/widgets/maps/friends_map_body.dart';
import 'package:travela_mobile/widgets/maps/previous_trips_map_body.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_alt_outlined),
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const FriendsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.8,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1,
        ),
        items: [
          Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FriendsMap(),
                    ),
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text('View Map', style: TextStyle(fontSize: 20)),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(child: FriendsMapBody()),
            ],
          ),
          Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiscoveryMap(),
                    ),
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text('View Map', style: TextStyle(fontSize: 20)),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(child: DiscoveryMapBody()),
            ],
          ),
          Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PreviousTripsMap(),
                    ),
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text('View Map', style: TextStyle(fontSize: 20)),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(child: PreviousTripsMapBody()),
            ],
          ),
        ],
      ),
    );
  }
}

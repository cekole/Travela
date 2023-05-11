import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:travela_mobile/screens/friends/friends_page.dart';
import 'package:travela_mobile/screens/maps/friends_map.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';
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
      ),
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 3),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColor.withOpacity(0.1),
              highlightColor: Colors.grey[200]!,
              child: const MapsBody(),
            );
          }
          return const MapsBody();
        },
      ),
    );
  }
}

class MapsBody extends StatelessWidget {
  const MapsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
    );
  }
}

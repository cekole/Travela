import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/screens/maps/friends_map.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/widgets/maps/friends_map_body.dart';
import 'package:travela_mobile/widgets/maps/previous_trips_map_body.dart';

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
        autoPlay: currentFriendsVisitedCities.isEmpty ? false : true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll:
            currentFriendsVisitedCities.isEmpty ? false : true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
      items: [
        if (!currentFriendsVisitedCities.isEmpty)
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
              Expanded(
                child: IgnorePointer(
                  child: FriendsMapBody(),
                ),
              ),
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
            Expanded(
              child: IgnorePointer(
                child: PreviousTripsMapBody(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

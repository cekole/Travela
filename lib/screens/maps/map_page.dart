import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/user_provider.dart';

import 'package:travela_mobile/screens/friends/friends_page.dart';
import 'package:travela_mobile/screens/maps/friends_map.dart';
import 'package:travela_mobile/screens/maps/previous_trips_map.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';
import 'package:travela_mobile/widgets/maps/friends_map_body.dart';
import 'package:travela_mobile/widgets/maps/map_body.dart';
import 'package:travela_mobile/widgets/maps/previous_trips_map_body.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: false);
    userData.getAllFriendsVisitedCitiesById();
    userData.getVisitedCitiesById();
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

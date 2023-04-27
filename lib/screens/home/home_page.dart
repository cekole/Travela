import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/screens/friends/friends_page.dart';
import 'package:travela_mobile/screens/maps/map_page.dart';
import 'package:travela_mobile/screens/profile/profile_page.dart';
import 'package:travela_mobile/screens/travel_group/travel_group.dart';
import 'package:travela_mobile/screens/groups/groups_page.dart';
import 'package:travela_mobile/screens/trips/trips_page.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';
import 'package:travela_mobile/widgets/home/home_body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageNum,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vrpano_outlined),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (value) {
          setState(() {
            pageNum = value;
          });
        },
      ),
      drawer: CustomDrawer(),
      body: pageNum == 0
          ? HomeBody()
          : pageNum == 1
              ? MapPage()
              : pageNum == 2
                  ? GroupsPage()
                  : pageNum == 3
                      ? TripsPage()
                      : ProfilePage(),
    );
  }
}

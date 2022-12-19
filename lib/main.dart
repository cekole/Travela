import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/activities_provider.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/recommendation_provider.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/screens/favorites/favorite_page.dart';
import 'package:travela_mobile/screens/hotel/hotel_page.dart';
import 'package:travela_mobile/screens/maps/friends_map.dart';
import 'package:travela_mobile/screens/maps/map_page.dart';
import 'package:travela_mobile/screens/profile/edit_profile.dart';
import 'package:travela_mobile/screens/search_options/search_options.dart';
import 'package:travela_mobile/screens/search_options/transportation_options.dart';
import 'package:travela_mobile/screens/travel_group/edit_travel_group.dart';
import 'package:travela_mobile/screens/friends/friends_page.dart';
import 'package:travela_mobile/screens/home/home_page.dart';
import 'package:travela_mobile/screens/login.dart';
import 'package:travela_mobile/screens/home/popular_destinations.dart';
import 'package:travela_mobile/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DestinationsProvider()),
        ChangeNotifierProvider(create: (context) => ActivitiesProvider()),
        ChangeNotifierProvider(create: (context) => TravelGroupProvider()),
        ChangeNotifierProvider(create: (context) => RecommendationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff859fd0),
          backgroundColor: Colors.white70,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black87,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white70,
            filled: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor: Color.fromARGB(179, 181, 204, 255),
              onSurface: Color.fromARGB(255, 60, 119, 168),
              primary: Colors.black87,
              minimumSize: const Size(100, 50),
            ),
          ),
        ),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => HomePage(),
          '/register': (context) => const RegisterPage(),
          '/friends': (context) => const FriendsPage(),
          '/popular': (context) => const PopularDestinations(),
          '/map': (context) => const MapPage(),
          '/friends-map': (context) => const FriendsMap(),
          '/edit_profile': (context) => const EditProfile(),
          '/edit_travel_group': (context) => const EditTravelGroup(),
          '/search_options': (context) => const SearchOptions(),
          '/hotel_page': (context) => const HotelPage(),
          '/transportation_options': (context) =>
              const TransportationOptionsPage(),
          '/favorites': (context) => FavoritesPage(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travela_mobile/screens/edit_profile.dart';
import 'package:travela_mobile/screens/friends_page.dart';
import 'package:travela_mobile/screens/home_page.dart';
import 'package:travela_mobile/screens/login.dart';
import 'package:travela_mobile/screens/map_page.dart';
import 'package:travela_mobile/screens/popular_destinations.dart';
import 'package:travela_mobile/screens/register.dart';
import 'package:travela_mobile/screens/seasons_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/seasons': (context) => const Seasons(),
        '/popular': (context) => const PopularDestinations(),
        '/map': (context) => const MapPage(),
        '/edit_profile': (context) => const EditProfile(),
      },
    );
  }
}

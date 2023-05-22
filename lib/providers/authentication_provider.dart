import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/user.dart';

class AuthenticationProvider with ChangeNotifier {
  final authUrl = baseUrl + 'authentication/';
  Future<bool> register({
    required String email,
    required String name,
    required String username,
    required String password,
  }) async {
    final url = authUrl + 'register';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'name': name,
        'username': username,
        'password': password,
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('register success');
      notifyListeners();
      return true;
    } else {
      print('register failed');
    }
    return false;
  }

  Future<bool> login({
    required String email,
    required String name,
    required String username,
    required String password,
  }) async {
    final url = authUrl + 'token';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Credentials': 'true'
      },
      body: json.encode({
        'email': email,
        'name': name,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('login success');

      bearerToken = response.body;
      print(bearerToken);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(bearerToken);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.body);
      prefs.setString('username', username);
      prefs.setString('email', email);
      prefs.setString('name', decodedToken['sub']);
      notifyListeners();
      return true;
    } else {
      print('login failed');
    }
    return false;
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
    return true;
  }

  //getCurrentUser
  Future<void> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final name = prefs.getString('name');
    if (token != null) {
      currentUser = User(
        id: '',
        name: name!,
        email: email!,
        username: username!,
        travelGroups: [],
        incomingGroupInvitations: [],
        tripsArchived: [],
        tripsShared: [],
        pastTrips: [],
        friends: [],
        incomingFriendRequests: [],
        outgoingFriendRequests: [],
        availableFrom: DateTime.now(),
        availableTo: DateTime.now(),
        visitedCities: [],
      );
    } else {
      print('token is null');
    }
    notifyListeners();
  }
}

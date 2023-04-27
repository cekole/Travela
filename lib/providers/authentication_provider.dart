import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider with ChangeNotifier {
  final authUrl = baseUrl + 'authentication/';
  Future<void> register({
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
    } else {
      print('register failed');
    }
    notifyListeners();
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.body);
      notifyListeners();
      return true;
    } else {
      print('login failed');
    }
    return false;
  }
}

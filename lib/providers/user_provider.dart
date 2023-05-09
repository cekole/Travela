import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/user.dart';

class UserProvider with ChangeNotifier {
  Future getAllUsers() async {
    final url = baseUrl + 'users';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('get all users success');
      return json.decode(response.body);
    } else {
      print('get all users failed');
    }
  }

  //getUserIdByUsername
  getUserIdByUsername(String username) {
    getAllUsers().then((value) {
      for (var user in value) {
        print(user['username']);
        if (user['username'] == username) {
          userId = user['user_id'].toString();
        }
      }
      notifyListeners();
    });
  }

  Future updateUserInfo(
      String id, String name, String username, String email) async {
    final url = baseUrl + 'users/$id';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'name': name,
      'username': username,
      'email': email,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('update user info success');
      return json.decode(response.body);
    } else {
      print('update user info failed');
    }
  }

  Future deleteUser(String id) async {
    final url = baseUrl + 'users/$id';
    print(url);
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('delete user success');
      return json.decode(response.body);
    } else {
      print('delete user failed');
    }
  }

  Future sendFriendRequest(String id, String friendId) async {
    final url = baseUrl + 'users/$id/sendFriendRequest/$friendId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);
  }

  Future acceptFriendRequest(String id, String friendId) async {
    final url = baseUrl + 'users/$id/acceptFriendRequest/$friendId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
  }

  Future rejectFriendRequest(String id, String friendId) async {
    final url = baseUrl + 'users/$id/rejectFriendRequest/$friendId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
  }

  Future removeFriend(String id, String friendId) async {
    final url = baseUrl + 'users/$id/removeFriend/$friendId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
  }

  Future<void> setAvailableFrom(String id, String date) async {
    final url = baseUrl + 'users/$id/setAvailableFrom/$date';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
  }

  Future<void> setAvailableTo(String id, String date) async {
    final url = baseUrl + 'users/$id/setAvailableTo/$date';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print('date' + date);
  }
}

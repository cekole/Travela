import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/trip.dart';
import 'package:travela_mobile/models/user.dart';
import 'package:travela_mobile/providers/group_provider.dart';

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

    if (response.statusCode == 200) {
      print('get all users success');
      return json.decode(response.body);
    } else {
      print('get all users failed');
    }
  }

  //getUserIdByUsername
  Future<void> getUserIdByUsername(String username) async {
    final value = await getAllUsers();
    for (var user in value) {
      if (user['username'] == username) {
        print(user['user_id']);
        //if username is currentUsername below, else set friendId
        if (username == currentUser.username) {
          print('you are the user');
          userId = user['user_id'].toString();
        } else {
          print('you are not the user');
          friendId = user['user_id'].toString();
        }
      }
      notifyListeners();
    }
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

  Future getAllFriends() async {
    final url = baseUrl + 'users/$userId/friends';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);
    //extract username and id of friends and set to currentFriendIds and currentFriendUsernames

    if (response.statusCode == 200) {
      print('get all friends success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      extractedData.forEach((friend) {
        //if currentFriendIds contains friend['user_id'], do not add
        if (currentFriendIds.contains(friend['user_id'])) {
          print('friend not added');
        } else {
          currentFriendUsernames.add(friend['username']);
          currentFriendIds.add(friend['user_id']);
        }
      });
      notifyListeners();
    } else {
      print('get all friends failed');
    }
  }

  Future getAllIncomingRequests() async {
    final url = baseUrl + 'users/$userId/incomingfriendRequests';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('get all incoming requests success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      extractedData.forEach((request) {
        if (currentRequestIds.contains(request['user_id'])) {
          print('request not added');
        } else {
          currentRequestIds.add(request['user_id']);
          currentRequestUsernames.add(request['username']);
        }
      });
      notifyListeners();
    } else {
      print('get all incoming requests failed');
    }
  }

  Future<bool> sendFriendRequest(String id, String friendId) async {
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
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
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
    print(response.statusCode);
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
    print(response.statusCode);
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
    if (response.statusCode == 200) {
      currentAvailableFrom = date;
      notifyListeners();
    } else {
      print('date not set');
    }
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
    if (response.statusCode == 200) {
      currentAvailableTo = date;
      notifyListeners();
    } else {
      print('date not set');
    }
  }

  Future<void> addFavouriteCity(String id, String cityId) async {
    final url = baseUrl + 'users/$id/addFavouriteCity/$cityId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    if (response.statusCode == 200) {
      print('add favorite city succeeded');
      notifyListeners();
    } else {
      print('add favorite city failed');
    }
  }

  Future<void> removeFavouriteCity(String id, String cityId) async {
    final url = baseUrl + 'users/$id/removeFavouriteCity/$cityId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    if (response.statusCode == 200) {
      print('removeFavouriteCity succeeded');
      notifyListeners();
    } else {
      print('removeFavouriteCity failed');
    }
  }

  Future<void> getTripSuggestions(String id) async {
    final url = baseUrl + 'groups/$id/trip-suggestions';
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
      print('getTripSuggestions for users succeeded');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (suggestion) {
          currentUserSuggestions.add(suggestion);
        },
      );
      notifyListeners();
    } else {
      print('getTripSuggestions for users failed');
    }
  }

  Future getTripDrafts(String userId) async {
    final url = baseUrl + 'users/$userId/trips-draft';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('get trip drafts success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (trip) {
          currentTripDrafts.add(trip);
        },
      );
      notifyListeners();
    } else {
      print('get trip drafts failed');
    }
  }

  Future getUpcomingTrips(String userId) async {
    final url = baseUrl + 'users/$userId/trips/shared';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('getUpcomingTrips success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (trip) {
          currentTripDrafts.add(trip);
        },
      );
      notifyListeners();
    } else {
      print('getUpcomingTrips failed');
    }
  }

  Future getAllFriendsVisitedCities(String userId, String friendId) async {
    final url = baseUrl + 'users/$userId/friendsVisitedCities/$friendId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('getAllFriendsVisitedCities success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      ;
      notifyListeners();
    } else {
      print('getAllFriendsVisitedCities failed');
    }
  }

  Future getAllFriendsVisitedCitiesById(String userId) async {
    final url = baseUrl + 'users/$userId/friendsVisitedCities';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('getAllFriendsVisitedCities success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (trip) {
          friendsVisitedCities.add(trip);
        },
      );
      notifyListeners();
    } else {
      print('getAllFriendsVisitedCities failed');
    }
  }

  void resetCurrentValues() {
    userId = '';
    friendId = '';

    currentFriendIds = [];
    currentFriendUsernames = [];

    currentRequestUsernames = [];
    currentRequestIds = [];

    currentGroupId = '';
    currentGroupUsernames = [];
    currentGroupTrips = [];

    currentGroupSuggestions = [];
    currentUserSuggestions = [];
    notifyListeners();
  }
}

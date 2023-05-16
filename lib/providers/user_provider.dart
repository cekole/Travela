import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/trip.dart';
import 'package:travela_mobile/models/user.dart';
import 'package:travela_mobile/providers/group_provider.dart';

class UserProvider with ChangeNotifier {
  List<Destination> _suggestedDestinations = [];

  List<Destination> get suggestedDestinations {
    return [..._suggestedDestinations];
  }

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
          currentAvailableFrom = user['availableFrom'];
          currentAvailableTo = user['availableTo'];
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

  Future<bool> addVisitedCity(String uId, String cityId) async {
    final url = baseUrl + 'users/$uId/addVisitedCity/$cityId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );
    if (response.statusCode == 200) {
      print('add visited city succeeded');
      notifyListeners();
      return true;
    } else {
      print('add visited city failed');
      return false;
    }
  }

  Future<void> getTripSuggestions(String id) async {
    final url = baseUrl + 'users/$id/trip-suggestions';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
    );
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<City> loadedCities = [];
    extractedData.forEach((city) {
      loadedCities.add(
        City(
          id: city['city_id'].toString(),
          cityName: city['cityName'],
          countryName:
              city['country'] == null ? '' : city['country']['countryName'],
          description:
              city['cityDescription'] == null ? '' : city['cityDescription'],
          imageUrl: city['cityImageURL'] == null ? '' : city['cityImageURL'],
          activities: city['activities'] == null ? [] : city['activities'],
          iataCode: city['iata_code'],
          latitude: city['latitude'],
          longitude: city['longitude'],
        ),
      );
    });
    _suggestedDestinations = loadedCities
        .map(
          (city) => Destination(
            id: city.id,
            country: city.countryName,
            city: city.cityName,
            description: city.description,
            imageUrl: city.imageUrl,
            rating: 4.5,
            location: 'Europe',
            activities: city.activities,
            isPopular: false,
          ),
        )
        .toList();
    notifyListeners();
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
    final url = baseUrl + 'users/$userId/trips/upcoming';
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
          upcomingTrips.add(trip);
        },
      );
      notifyListeners();
    } else {
      print('getUpcomingTrips failed');
    }
  }

  Future getPastTrips(String userId) async {
    final url = baseUrl + 'users/$userId/trips/past';
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
      print('getPastTrips success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (trip) {
          pastTrips.add(trip);
        },
      );
      notifyListeners();
    } else {
      print('getPastTrips failed');
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

  Future getFavouriteCities(String userId) async {
    final url = baseUrl + 'users/$userId/favouriteCities';
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
      print('getFavouriteCities success');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach(
        (trip) {
          favouriteCities.add(trip);
        },
      );
      notifyListeners();
    } else {
      print('getFavouriteCities failed');
    }
  }

  Future<void> resetCurrentValues() async {
    userId = '';
    friendId = '';

    currentFriendIds = [];
    currentFriendUsernames = [];

    currentRequestUsernames = [];
    currentRequestIds = [];

    currentGroupId = '';
    currentGroupIdForSuggestions = '';
    currentGroupUsernames = [];
    currentGroupTrips = [];

    currentGroupSuggestions = [];
    currentUserSuggestions = [];

    currentAvailableFrom = '';
    currentAvailableTo = '';

    favouriteCities = [];
    currentTripDrafts = [];
    notifyListeners();
  }
}

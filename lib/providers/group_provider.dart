import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/user.dart';

class GroupProvider with ChangeNotifier {
  Future addGroup(String groupName, String ownerId) async {
    final url = baseUrl + 'groups';
    print(url);
    final response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'groupName': groupName,
      'ownerId': ownerId,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addGroup succeeded');
      return json.decode(response.body);
    } else {
      print('addGroup failed');
    }
  }

  Future deleteGroup(String id) async {
    final url = baseUrl + 'groups/$id';
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
      print('deleteGroup succeeded');
      return json.decode(response.body);
    } else {
      print('deleteGroup failed');
    }
  }

  Future updateGroup(String id, String groupName, String ownerId) async {
    final url = baseUrl + 'groups/$id';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'groupName': groupName,
      'ownerId': ownerId,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('updateGroup succeeded');
      return json.decode(response.body);
    } else {
      print('updateGroup failed');
    }
  }

  Future getTrips(String id) async {
    final url = baseUrl + 'groups/$id/trips';
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
      print('getTrips succeeded');
      return json.decode(response.body);
    } else {
      print('getTrips failed');
    }
  }

  Future getParticipants(String id) async {
    final url = baseUrl + 'groups/$id/participants';
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
      print('getParticipants succeeded');
      return json.decode(response.body);
    } else {
      print('getParticipants failed');
    }
  }

  Future addUserToGroup(String groupId, String userId) async {
    final url = baseUrl + 'groups/$groupId/addUser/$userId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('addUser succeeded');
      return json.decode(response.body);
    } else {
      print('addUser failed');
    }
  }

  Future removeUserFromGroup(String groupId, String userId) async {
    final url = baseUrl + 'groups/$groupId/removeUser/$userId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('removeUserFromGroup succeeded');
      return json.decode(response.body);
    } else {
      print('removeUserFromGroup failed');
    }
  }

  Future addTrip(String groupId, String cityId) async {
    final url = baseUrl + 'groups/$groupId/trips/add/$cityId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addTrip succeeded');
      return json.decode(response.body);
    } else {
      print('addTrip failed');
    }
  }

  Future getChat(String id) async {
    final url = baseUrl + 'groups/$id/chat';
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
      print('chat succeeded');
      return json.decode(response.body);
    } else {
      print('chat failed');
    }
  }

  Future sendMessage(String id) async {
    final url = baseUrl + 'groups/$id/chat/send';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('sendMessage succeeded');
      return json.decode(response.body);
    } else {
      print('sendMessage failed');
    }
  }

  Future getgetTripSuggestions(String id) async {
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
      print('getgetTripSuggestions succeeded');
      return json.decode(response.body);
    } else {
      print('getgetTripSuggestions failed');
    }
  }

  Future updateCommonDates(String groupId) async {
    final url = baseUrl + 'groups/$groupId/updateCommonDates';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('updateCommonDates succeeded');
      return json.decode(response.body);
    } else {
      print('updateCommonDates failed');
    }
  }

  Future updateCommonCities(String groupId) async {
    final url = baseUrl + 'groups/$groupId/updateCommonCities';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('updateCommonCities succeeded');
      return json.decode(response.body);
    } else {
      print('updateCommonCities failed');
    }
  }
}

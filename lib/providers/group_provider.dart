import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/user.dart';

class GroupProvider with ChangeNotifier {
  List<TravelGroup> _groups = [];

  List<TravelGroup> get groups {
    return [..._groups];
  }

  Future<void> fetchAndSetGroupsByUserId(String uId) async {
    final url = baseUrl + 'groups/user/$uId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    print(response.body);
    final List<TravelGroup> loadedGroups = [];
    final extractedData = json.decode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return;
    }

    extractedData.forEach(
      (group) {
        currentGroupUsernames = group['participants'];
        currentGroupTrips = group['trips'];
        loadedGroups.add(
          TravelGroup(
            id: group['group_id'].toString(),
            groupName: group['groupName'],
            participants: [], //stored in currentGroupParticipants
            commonStartDate: group['commonStartDate'] ?? '',
            commonEndDate: group['commonEndDate'] ?? '',
            trips: [], //stored in currentGroupTrips
          ),
        );
      },
    );
    _groups = loadedGroups;
    notifyListeners();
  }

  Future<void> getGroupById(String groupId) async {
    final url = baseUrl + 'groups/$groupId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
  }

  Future<void> getGroupByUserId(String uId) async {
    final url = baseUrl + 'groups/user/$uId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    print('getGroupByUserId');
    print(response.body);
    if (response.statusCode == 200) {
      print('getGroupByUserId succeeded');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      currentGroupId = extractedData.last['group_id'].toString();
      print('currentGroupId');
      print(currentGroupId);

      notifyListeners();

      return json.decode(response.body);
    } else {
      print('getGroupByUserId failed');
    }
  }

  Future<void> addGroup(String groupName, String ownerId) async {
    final url = baseUrl + 'groups';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'groupName': groupName,
          'ownerId': ownerId,
        },
      ),
    );
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

  Future<void> getParticipants(String groupId) async {
    final url = baseUrl + 'groups/$groupId/participants';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('getParticipants succeeded');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      //get the participants username
      final List<String> loadedParticipants = [];
      extractedData.forEach(
        (participant) {
          loadedParticipants.add(participant['username']);
        },
      );
      currentGroupUsernames = loadedParticipants;
      notifyListeners();
      return json.decode(response.body);
    } else {
      print('getParticipants failed');
    }
  }

  Future<bool> addUserToGroup(String groupId, String uId) async {
    final url = baseUrl + 'groups/$groupId/addUser/$uId';
    print(url);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('addUser succeeded');
      return true;
    } else {
      print('addUser failed');
      return false;
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

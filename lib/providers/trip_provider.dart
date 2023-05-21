import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/user.dart';
import 'package:travela_mobile/models/travel_group.dart';

class TripProvider with ChangeNotifier {
  Future getAll() async {
    final url = baseUrl + 'trips';
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
      print('get all trips success');
      return json.decode(response.body);
    } else {
      print('get all trips failed');
    }
  }

  Future<int> addTrip(
    String tripName,
    String tripDescription,
    int groupId,
  ) async {
    final url = '${baseUrl}trips';
    print(url);

    final body = {
      'tripName': tripName,
      'tripDescription': tripDescription,
      'group_id': groupId,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final tripId = responseData['trip_id'];
        print('Trip added successfully! Trip ID: $tripId');
        return tripId;
      } else {
        print('Failed to add trip. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return 0;
  }

  Future<void> addLocation(int tripId, int cityId) async {
    final url = '${baseUrl}trips/$tripId/locations/add/$cityId';
    print(url);

    final headers = {
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Location added successfully!');
      } else {
        print('Failed to add location. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future addTransportation(String tripId, String tripDescription,
      String groupId, String tripName) async {
    final url = baseUrl + 'trips/$tripId/transportations/add';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'tripName': tripName,
      'tripDescription': tripDescription,
      'groupId': groupId,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addTransportation success');
      return json.decode(response.body);
    } else {
      print('addTransportation failed');
    }
  }

  Future addAccomodation(
      String tripId,
      String name,
      String price,
      String link,
      String address,
      String description,
      String type,
      String rating,
      String image) async {
    final url = baseUrl + 'trips/$tripId/transportations/add';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'name': name,
      'price': price,
      'link': link,
      'address': address,
      'description': description,
      'type': type,
      'rating': rating,
      'image': image,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addAccomodation success');
      return json.decode(response.body);
    } else {
      print('addAccomodation failed');
    }
  }

  Future updateTrip(String id, String tripName, String tripDescription,
      String groupId) async {
    final url = baseUrl + 'trips/$id';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'tripName': tripName,
      'tripDescription': tripDescription,
      'groupId': groupId,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('updateCountry succeeded');
      return json.decode(response.body);
    } else {
      print('updateCountry failed');
    }
  }

  Future deleteTrip(String tripId) async {
    final url = baseUrl + 'trips/$tripId';
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
      print('deleteTrip succeeded');
      return json.decode(response.body);
    } else {
      print('deleteTrip failed');
    }
  }

  Future getTransportations(String id) async {
    final url = baseUrl + 'trips/$id/transportations';
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
      print('get all transportations success');
      return json.decode(response.body);
    } else {
      print('get all transportations failed');
    }
  }

  Future get(String id) async {
    final url = baseUrl + 'trips/$id/transportations';
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
      print('get all transportations success');
      return json.decode(response.body);
    } else {
      print('get all transportations failed');
    }
  }

  Future getLocations(String id) async {
    final url = baseUrl + 'trips/$id/locations';
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
      print('get all locations success');
      return json.decode(response.body);
    } else {
      print('get all locations failed');
    }
  }

  Future getStartDate(String id) async {
    final url = baseUrl + 'trips/$id/startDate';
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
      print('getStartDate success');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      endDate = extractedData['startDate'];
      notifyListeners();
    } else {
      print('getStartDate failed');
    }
  }

  Future getEndDate(String id) async {
    final url = baseUrl + 'trips/$id/endDate';
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
      print('getEndDate success');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      endDate = extractedData['endDate'];
      notifyListeners();
    } else {
      print('getEndDate failed');
    }
  }
}

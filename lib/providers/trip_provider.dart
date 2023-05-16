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

  Future addCountry(
      String tripName, String tripDescription, TravelGroup travelGroup) async {
    final url = baseUrl + 'trips';
    print(url);
    final response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'tripName': tripName,
      'tripDescription': tripDescription,
      'travelGroup': travelGroup,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addTransportation success');
      return json.decode(response.body);
    } else {
      print('addTransportation failed');
    }
  }

  Future updateCountry(String id, String tripName, String tripDescription,
      TravelGroup travelGroup) async {
    final url = baseUrl + 'trips/$id';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'tripName': tripName,
      'tripDescription': tripDescription,
      'travelGroup': travelGroup,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('updateCountry succeeded');
      return json.decode(response.body);
    } else {
      print('updateCountry failed');
    }
  }

  Future deleteCountry(String id) async {
    final url = baseUrl + 'trips/$id';
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
      print('deleteCountry succeeded');
      return json.decode(response.body);
    } else {
      print('deleteCountry failed');
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
      return json.decode(response.body);
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
      return json.decode(response.body);
    } else {
      print('getEndDate failed');
    }
  }
}

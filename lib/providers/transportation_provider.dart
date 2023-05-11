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

class TransportationProvider with ChangeNotifier {
  Future getAll() async {
    final url = baseUrl + 'transportations';
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

  Future getById(String id) async {
    final url = baseUrl + 'transportations/$id';
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
      print('get all transportations by id success');
      return json.decode(response.body);
    } else {
      print('get all transportations by id failed');
    }
  }

  Future addTransportation(
      City startCity,
      City endCity,
      String transportationType,
      String link,
      int price,
      DateTime start,
      Duration duration,
      String trip_id) async {
    final url = baseUrl + 'transportations';
    print(url);
    final response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'startCity': startCity,
      'endCity': endCity,
      'transportationType': transportationType,
      'link': link,
      'price': price,
      'start': start,
      'duration': duration,
      'trip_id': trip_id,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addTransportation success');
      return json.decode(response.body);
    } else {
      print('addTransportation failed');
    }
  }

  Future updateTransportation(
      String id,
      City startCity,
      City endCity,
      String transportationType,
      String link,
      int price,
      DateTime start,
      Duration duration,
      String trip_id) async {
    final url = baseUrl + 'transportations/$id';
    print(url);
    final response = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer  $bearerToken',
      'Content-Type': 'application/json',
    }, body: {
      'startCity': startCity,
      'endCity': endCity,
      'transportationType': transportationType,
      'link': link,
      'price': price,
      'start': start,
      'duration': duration,
      'trip_id': trip_id,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('updateTransportation succeeded');
      return json.decode(response.body);
    } else {
      print('updateTransportation failed');
    }
  }

  Future deleteTransportation(String id) async {
    final url = baseUrl + 'transportations/$id';
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
      print('deleteTransportation success');
      return json.decode(response.body);
    } else {
      print('deleteTransportation failed');
    }
  }
}

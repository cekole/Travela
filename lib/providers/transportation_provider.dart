import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/transportation.dart';
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

  Future<Map<String, dynamic>?> addTransportation(
    String startCityId,
    String endCityId,
    String transportationType,
    String link,
    double price,
    String start,
    double duration,
    String tripId,
  ) async {
    final url = baseUrl + 'transportations';
    print(url);

    final requestBody = json.encode({
      'startCity': int.parse(startCityId),
      'endCity': int.parse(endCityId),
      'transportationType': transportationType,
      'link': link,
      'price': price,
      'start': start,
      'duration': duration,
      'trip_id': int.parse(tripId),
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addTransportation success');
      return json.decode(response.body);
    } else {
      print('addTransportation failed');
    }
  }

  Future<void> updateTransportation(
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

  Future searchTransportation(String departureDate, String originLocationCode,
      String destinationLocationCode, int adults) async {
    final url =
        '${baseUrl}transportations/search?departureDate=$departureDate&originLocationCode=$originLocationCode&destinationLocationCode=$destinationLocationCode&adults=$adults';

    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final listExtracted =
          extractedData['transportationList'] as List<dynamic>;

      listExtracted.forEach((item) {
        final duration = item['itinerary']['duration'] as String;
        final price = item['price'] as String;

        final segments = item['itinerary']['segments'] as List<dynamic>;
        final departure = segments[0]['departure'] as String;
        final arrival = segments[segments.length - 1]['arrival'] as String;

        // Clear the list and then add the new items
        currentTransportations
            .add([duration, price, departure, arrival, segments]);
      });
      print(currentTransportations);
      return currentTransportations;
    } else {
      print('error');
    }

    notifyListeners();
  }
}

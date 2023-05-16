import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/appConstant.dart';

class RecommendationProvider with ChangeNotifier {
  List<String> _enteredLocations = [];
  String nation = '';
  String previousCities = '';

  List<String> get enteredLocations {
    return [..._enteredLocations];
  }

  void setNation(String nation) {
    this.nation = nation;
  }

  void setPreviousCities(String previousCities) {
    this.previousCities = previousCities;
  }

  Future<void> fetchAndSetRecommendations(
      String cityCode, String countryCode) async {
    final url = Uri.parse(
        'https://test.api.amadeus.com/v1/reference-data/recommended-locations?cityCodes=$cityCode&travelerCountryCode=$countryCode');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $amadeusBearer',
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<String> loadedLocations = [];
      extractedData['data'].forEach((locationData) {
        loadedLocations.add(locationData['name']);
      });
      _enteredLocations = loadedLocations;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //https://test.api.amadeus.com/v1/security/oauth2/token
  //grant_type=client_credentials&client_id
  Future<void> getToken() async {
    String amadeusClientId = 'iAFSooFSofaCnXzcY7Lx79MnAAnbkdqe';
    String amadeusClient = '4C6SCuRAoswrHroI';
    final url =
        Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token');
    try {
      final response = await http.post(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }, body: {
        'grant_type': 'client_credentials',
        'client_id': amadeusClientId,
        'client_secret': amadeusClient,
      });

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      amadeusBearer = extractedData['access_token'];
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

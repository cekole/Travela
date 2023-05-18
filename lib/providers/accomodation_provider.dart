import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/accomodation.dart';
import 'package:http/http.dart' as http;

class AccomodationProvider with ChangeNotifier {
  final requestUrl = baseUrl + 'accomodations';
  List<Accomodation> _accomodations = [];

  List<Accomodation> get accomodations {
    return [..._accomodations];
  }

  Future<void> fetchAllAccomodations() async {
    final response = await http.get(Uri.parse(requestUrl));
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<Accomodation> loadedAccomodations = [];
    extractedData.forEach((accomodationData) {
      loadedAccomodations.add(
        Accomodation(
          name: accomodationData['name'],
          price: accomodationData['price'],
          link: accomodationData['link'],
          address: accomodationData['address'],
          description: accomodationData['description'],
          type: accomodationData['type'],
          rating: accomodationData['rating'],
          image: accomodationData['image'],
        ),
      );
    });
    _accomodations = loadedAccomodations;
    notifyListeners();
  }

  Future<Accomodation> getAccomodationById(String id) async {
    final response = await http.get(Uri.parse(requestUrl + '/$id'));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final loadedAccomodation = Accomodation(
      name: extractedData['name'],
      price: extractedData['price'],
      link: extractedData['link'],
      address: extractedData['address'],
      description: extractedData['description'],
      type: extractedData['type'],
      rating: extractedData['rating'],
      image: extractedData['image'],
    );
    return loadedAccomodation;
  }

  Future<void> addAccomodation(Accomodation accomodation) async {
    final response = await http.post(
      Uri.parse(requestUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'name': accomodation.name,
        'price': accomodation.price,
        'link': accomodation.link,
        'address': accomodation.address,
        'description': accomodation.description,
        'type': accomodation.type,
        'rating': accomodation.rating,
        'image': accomodation.image,
      }),
    );
    final newAccomodation = Accomodation(
      name: accomodation.name,
      price: accomodation.price,
      link: accomodation.link,
      address: accomodation.address,
      description: accomodation.description,
      type: accomodation.type,
      rating: accomodation.rating,
      image: accomodation.image,
    );
    _accomodations.add(newAccomodation);
    notifyListeners();
  }

  Future<void> updateAccomodation(
      String id, Accomodation newAccomodation) async {
    final response = await http.put(
      Uri.parse(requestUrl + '/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'name': newAccomodation.name,
        'price': newAccomodation.price,
        'link': newAccomodation.link,
        'address': newAccomodation.address,
        'description': newAccomodation.description,
        'type': newAccomodation.type,
        'rating': newAccomodation.rating,
        'image': newAccomodation.image,
      }),
    );
  }

  Future<void> deleteAccomodation(String id) async {
    final response = await http.delete(Uri.parse(requestUrl + '/$id'));

    //accomodationın idsi dönmüyo şu anlık namei id olarak aldım değişebilir
    _accomodations.removeWhere((accomodation) => accomodation.name == id);
    notifyListeners();
  }

  Future<String> searchAccomodation(String city, String startDate,
      String destinationDate, int adultsCount) async {
    final url = baseUrl + 'accomodations/search';

    var queryParams = {
      'city': city,
      'startDate': startDate,
      'destinationDate': destinationDate,
      'adultsCount': adultsCount.toString(),
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer  $bearerToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(
            'Search request failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while making the search request: $e');
    }
  }
}

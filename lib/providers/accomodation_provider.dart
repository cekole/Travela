import 'dart:convert';
import 'dart:math';

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

  Future<List<Accomodation>> fetchAllAccomodations() async {
    final response = await http.get(Uri.parse(requestUrl), headers: {
      'Authorization': 'Bearer $bearerToken',
    });
    print(response.statusCode);
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
          location: accomodationData['location'],
        ),
      );
    });
    _accomodations = loadedAccomodations;
    notifyListeners();
    return accomodations;
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
      location: extractedData['location'],
    );
    return loadedAccomodation;
  }

  Future<Map<String, dynamic>?> addAccomodation(
      Map<String, dynamic> accomodationData) async {
    final url = Uri.parse(requestUrl);
    print(url);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
      body: jsonEncode(accomodationData),
    );
    print(accomodationData);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Accomodation added successfully');
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print(data);
      return data;
    }

    return null;
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

  Future searchAccomodation(String city, String startDate,
      String destinationDate, int adultsCount) async {
    final url =
        '${baseUrl}accomodations/search?city=$city&startDate=$startDate&endDate=$destinationDate&adultsCount=$adultsCount';
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
      final listExtracted = extractedData['propertyList'] as List<dynamic>;
      listExtracted.forEach((item) {
        final name = item['name'] as String;
        final price = item['price'] as String;
        final imageUrl = item['imageUrl'] as String;
        //first clear the list and then add the new items
        currentAccomodations.add([name, price, imageUrl]);
      });
      return currentAccomodations;
    } else {
      print('error');
    }
    notifyListeners();
  }
}

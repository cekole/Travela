import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:http/http.dart' as http;

class DestinationsProvider with ChangeNotifier {
  final destinationUrl = baseUrl + 'cities';
  List<Destination> _destinations = [
    /* Destination(
      id: '1',
      country: 'France',
      city: 'Paris',
      description: 'Paris is the capital city of France',
      imageUrl: 'assets/images/destinations/destination_1.jpeg',
      rating: 4.5,
      location: 'Europe',
      activities: [
        'Eiffel Tower',
        'Louvre Museum',
        'Notre Dame Cathedral',
        'Arc de Triomphe',
        'Champs-Élysées',
        'Seine River',
      ],
      isPopular: false,
    ),
    Destination(
      id: '2',
      country: 'United Kingdom',
      city: 'London',
      description: 'London is the capital city of the UK',
      imageUrl: 'assets/images/destinations/destination_2.jpeg',
      rating: 3.5,
      location: 'Europe',
      activities: [
        'Big Ben',
        'Tower Bridge',
        'London Eye',
        'Buckingham Palace',
        'Westminster Abbey',
        'Trafalgar Square',
      ],
      isPopular: true,
    ),
    Destination(
      id: '3',
      country: 'United States',
      city: 'New York',
      description: 'New York is the most populous city in the United States',
      imageUrl: 'assets/images/destinations/destination_3.jpeg',
      rating: 4.0,
      location: 'North America',
      activities: [
        'Statue of Liberty',
        'Empire State Building',
        'Central Park',
        'Times Square',
        'Brooklyn Bridge',
        'Rockefeller Center',
      ],
      isPopular: false,
    ),
    Destination(
      id: '4',
      country: 'Italy',
      city: 'Venice',
      description: 'Venice is a city in northeastern Italy',
      imageUrl: 'assets/images/destinations/venice.jpg',
      rating: 4.5,
      location: 'Europe',
      activities: [
        'St. Mark\'s Square',
        'Grand Canal',
        'Rialto Bridge',
        'Piazza San Marco',
        'Gondola Ride',
        'Doge\'s Palace',
      ],
      isPopular: true,
    ),
    Destination(
      id: '5',
      country: 'Switzerland',
      city: 'Basel',
      description: 'Basel is a city in northwestern Switzerland',
      imageUrl: 'assets/images/destinations/basel.jpg',
      rating: 4.5,
      location: 'Europe',
      activities: [
        'Basel Zoo',
        'Basel Minster',
        'Basel Historical Museum',
        'Basel Town Hall',
        'Basel SBB Train Station',
        'Basel University',
      ],
      isPopular: true,
    ) */
  ];

  List<Destination> _popularDestinations = [];

  List<Destination> get destinations {
    return [..._destinations];
  }

  List<Destination> get popularDestinationsList {
    return [..._popularDestinations];
  }

  Destination findById(String id) {
    return _destinations.firstWhere((destination) => destination.id == id);
  }

  //fetch and set destinations
  Future<void> fetchAndSetCities() async {
    final response = await http.get(
      Uri.parse(destinationUrl),
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
    _destinations = loadedCities
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

  Future<void> getPopularCities() async {
    final response = await http.get(
      Uri.parse(destinationUrl + '/most-popular'),
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
    _popularDestinations = loadedCities
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

  void updateDestination(String id, Destination newDestination) {
    final destinationIndex =
        _destinations.indexWhere((destination) => destination.id == id);
    if (destinationIndex >= 0) {
      _destinations[destinationIndex] = newDestination;
      notifyListeners();
    } else {
      print('...');
    }
  }
}

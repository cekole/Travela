import 'package:flutter/material.dart';
import 'package:travela_mobile/models/destination.dart';

class Destinations with ChangeNotifier {
  List<Destination> _destinations = [
    Destination(
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
    )
  ];

  List<Destination> get destinations {
    return [..._destinations];
  }

  Destination findById(String id) {
    return _destinations.firstWhere((destination) => destination.id == id);
  }

  void addDestination() {
    // _destinations.add(value);
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
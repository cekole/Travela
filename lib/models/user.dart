import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/trip.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String name;
  final List<TravelGroup> travelGroups;
  final List<TravelGroup> incomingGroupInvitations;
  final List<Trip> tripsArchived;
  final List<Trip> tripsShared;
  final List<Trip> pastTrips;
  final List<User> friends;
  final List<User> incomingFriendRequests;
  final List<User> outgoingFriendRequests;
  final DateTime availableFrom;
  final DateTime availableTo;
  final List<City> visitedCities;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.travelGroups,
    required this.incomingGroupInvitations,
    required this.tripsArchived,
    required this.tripsShared,
    required this.pastTrips,
    required this.friends,
    required this.incomingFriendRequests,
    required this.outgoingFriendRequests,
    required this.availableFrom,
    required this.availableTo,
    required this.visitedCities,
  });
}

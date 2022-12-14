import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/models/trip.dart';
import 'package:travela_mobile/models/user.dart';

class TravelGroup {
  final String name;
  final String description;
  final List<User> participants;
  final List<Trip> trips;
  final String imageUrl;
  final List<Destination> destinations;

  TravelGroup({
    required this.name,
    required this.description,
    required this.participants,
    required this.trips,
    required this.imageUrl,
    required this.destinations,
  });
}

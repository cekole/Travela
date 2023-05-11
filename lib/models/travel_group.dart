import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/models/trip.dart';
import 'package:travela_mobile/models/user.dart';

class TravelGroup {
  final String id;
  final String groupName;
  final List<User> participants;
  final List<Trip> trips;
  final String commonStartDate;
  final String commonEndDate;

  TravelGroup({
    required this.id,
    required this.groupName,
    required this.participants,
    required this.trips,
    required this.commonStartDate,
    required this.commonEndDate,
  });
}

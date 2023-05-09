import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/user.dart';

User currentUser = User(
  id: '',
  username: '',
  email: '',
  name: '',
  travelGroups: [],
  incomingGroupInvitations: [],
  tripsArchived: [],
  tripsShared: [],
  pastTrips: [],
  friends: [],
  incomingFriendRequests: [],
  outgoingFriendRequests: [],
  availableFrom: DateTime.now(),
  availableTo: DateTime.now(),
  visitedCities: [],
);
String baseUrl = "http://localhost:8081/";
String amadeusBearer = '';
String bearerToken = '';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/user.dart';

String userId = '';
String friendId = '';

List currentFriendIds = [];
List currentFriendUsernames = [];

List currentRequestUsernames = [];
List currentRequestIds = [];

String currentGroupId = '';
List currentGroupUsernames = [];
List currentGroupTrips = [];

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

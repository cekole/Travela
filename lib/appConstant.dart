import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/user.dart';

String userId = '';
String friendId = '';

var currentUsername = '';
var currentEmail = '';
var currentName = '';
List<TravelGroup> currentTravelGroups = [];
var currentIncomingGroupInvitations = [];
var currentTripsArchived = [];
var currentTripsShared = [];
var currentPastTrips = [];
var currentFriends = [];
var currentIncomingFriendRequests = [];
var currentOutgoingFriendRequests = [];
var currentAvailableFrom = '';
var currentAvailableTo = '';
var currentVisitedCities = [];
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

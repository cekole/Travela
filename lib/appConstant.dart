import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/user.dart';
import 'package:travela_mobile/models/trip.dart';

int pageNum = 0;

String userId = '';
String friendId = '';
String userEmail = '';
String userUsername = '';

List currentFriendIds = [];
List currentFriendUsernames = [];

List currentRequestUsernames = [];
List currentRequestIds = [];

String currentGroupId = '';
String currentGroupIdForSuggestions = '';
List currentGroupUsernames = [];
List currentGroupTrips = [];

List currentGroupSuggestions = [];
List currentUserSuggestions = [];

String currentAvailableFrom = '';
String currentAvailableTo = '';

DateTime endDate = DateTime.now();
DateTime startDate = DateTime.now();

List favouriteCities = [];
List<Trip> currentTripDrafts = [];
List currentVisitedCities = [];
List currentFriendsVisitedCities = [];

var profilePic;
List<String> tripPhotos = [];

List<Trip> upcomingTrips = [];
List<Trip> pastTrips = [];
List draftTrips = [];

List currentAccomodations = [];
List currentTransportations = [];

String currentTripId = '';

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
String baseUrl = "http://13.48.206.213:8081/";
//for local testing
//String baseUrl = "http://localhost:8081/";

String amadeusBearer = '';
String bearerToken = '';

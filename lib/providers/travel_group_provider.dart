import 'package:flutter/material.dart';
import 'package:travela_mobile/models/accomodation.dart';
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/trip.dart';
import 'package:travela_mobile/models/user.dart';

class TravelGroupProvider with ChangeNotifier {
  List<TravelGroup> _travelGroups = [
    TravelGroup(
      id: '1',
      groupName: 'Swiss Alps Buddies',
      commonStartDate: DateTime.now().toString(),
      commonEndDate: DateTime.now().toString(),
      participants: [
        User(
          id: '1',
          name: 'Yağmur Eryılmaz',
          email: 'yagmurery@gmail.com',
          username: 'yagmurery',
          visitedCities: [],
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
        ),
      ],
      trips: [],
    ),
    TravelGroup(
      id: '2',
      groupName: 'Trippies',
      commonStartDate: DateTime.now().toString(),
      commonEndDate: DateTime.now().toString(),
      participants: [
        User(
          id: '1',
          name: 'Yağmur Eryılmaz',
          email: 'yagmurery@gmail.com',
          username: 'yagmurery',
          visitedCities: [],
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
        ),
        User(
          id: '2',
          name: 'Cenk Duran',
          email: 'cekoley@gmail.com',
          username: 'cekole',
          visitedCities: [],
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
        ),
        User(
          id: '3',
          name: 'Efe Ertürk',
          email: 'efeerturk@gmail.com',
          username: 'efeerturk',
          visitedCities: [],
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
        ),
        User(
          id: '4',
          name: 'Efe Şaman',
          email: 'efesaman@gmail.com',
          username: 'efesaman',
          visitedCities: [],
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
        ),
        User(
          id: '5',
          name: 'Çağla Ataoğlu',
          email: 'caglaataoglu@gmail.com',
          username: 'caglaataoglu',
          visitedCities: [],
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
        ),
      ],
      trips: [],
    ),
  ];

  List<TravelGroup> get travelGroups {
    return [..._travelGroups];
  }
}

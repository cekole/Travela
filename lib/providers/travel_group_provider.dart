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
      trips: [
        Trip(
          id: '1',
          period: 'August 2022',
          locations: ['Zurich', 'Bern', 'Geneva'],
          imageUrl: 'assets/images/travel_groups/travel_group_1.jpeg',
          accomodation: Accomodation(
            name: 'Hotel Schweizerhof',
            price: '100.000',
            link:
                'https://www.booking.com/hotel/ch/schweizerhof-zurich.en-gb.html',
            address: 'Schweizerhofstrasse 1, 8001 Zurich, Switzerland',
            description:
                'Hotel Schweizerhof is located in the heart of Zurich, just 200 metres from the main train station. It offers a restaurant, a bar and free WiFi.',
            type: 'Hotel',
            rating: '4.2',
            image: 'assets/images/accomodations/accomodation_1.jpeg',
          ),
          quickNotes: 'We will meet at the airport.',
        ),
      ],
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
      trips: [
        Trip(
          id: '1',
          period: 'June 2022',
          locations: ['Berlin'],
          imageUrl: 'assets/images/travel_groups/travel_group_2.jpeg',
          accomodation: Accomodation(
            name: 'Hotel Berlin',
            price: '100.000',
            link: 'https://www.booking.com/hotel/de/berlin.en-gb.html',
            address: 'Berlinstrasse 1, 8001 Berlin, Germany',
            description:
                'Hotel Berlin is located in the heart of Berlin, just 200 metres from the main train station. It offers a restaurant, a bar and free WiFi.',
            type: 'Hotel',
            rating: '4.2',
            image: 'assets/images/accomodations/accomodation_2.jpeg',
          ),
          quickNotes: 'We will meet at the airport.',
        ),
      ],
    ),
  ];

  List<TravelGroup> get travelGroups {
    return [..._travelGroups];
  }
}

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
      name: 'Swiss Alps Buddies',
      description: 'Switzerland, August 2022',
      participants: [
        User(
          name: 'Yağmur Eryılmaz',
          email: 'yagmurery@gmail.com',
          messages: [
            'Hi, I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
          ],
          country: Country(
            countryName: 'Spain',
            cities: [
              City(
                cityName: 'Sevilla',
                countryId: '1',
                activities: [
                  'Visit the Cathedral',
                  'Visit the Alcazar',
                ],
              ),
            ],
          ),
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
      imageUrl: 'assets/images/travel_groups/travel_group_1.jpeg',
      destinations: [
        Destination(
          id: '1',
          country: 'Switzerland',
          city: 'Zurich',
          description: 'Zurich is the largest city in Switzerland',
          imageUrl: 'assets/images/destinations/destination_1.jpeg',
          rating: 4.5,
          location: 'Europe',
          activities: [
            'Zurich Zoo',
            'Zurich Opera House',
            'Zurich Lake',
            'Zurich Museum of Art',
            'Zurich Botanical Garden',
            'Zurich Cathedral',
          ],
          isPopular: false,
        ),
        Destination(
          id: '2',
          country: 'Switzerland',
          city: 'Bern',
          description: 'Bern is the capital city of Switzerland',
          imageUrl: 'assets/images/destinations/destination_2.jpeg',
          rating: 3.5,
          location: 'Europe',
          activities: [
            'Bern Zoo',
            'Bern Museum of Art',
            'Bern Botanical Garden',
            'Bern Cathedral',
            'Bern Opera House',
            'Bern Lake',
          ],
          isPopular: true,
        ),
        Destination(
          id: '3',
          country: 'Switzerland',
          city: 'Geneva',
          description: 'Geneva is the second most populous city in Switzerland',
          imageUrl: 'assets/images/destinations/destination_3.jpeg',
          rating: 4.0,
          location: 'Europe',
          activities: [
            'Geneva Zoo',
            'Geneva Museum of Art',
            'Geneva Botanical Garden',
            'Geneva Cathedral',
            'Geneva Opera House',
            'Geneva Lake',
          ],
          isPopular: false,
        ),
      ],
    ),
    TravelGroup(
      name: 'Trippies',
      description: 'Berlin, June 2022',
      participants: [
        User(
          name: 'Yağmur Eryılmaz',
          email: 'yagmurery@gmail.com',
          messages: [
            'Hi, I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
          ],
          country: Country(
            countryName: 'Spain',
            cities: [
              City(
                cityName: 'Sevilla',
                countryId: 'ESP',
                activities: [
                  'Visit the Cathedral',
                  'Visit the Alcazar',
                ],
              ),
            ],
          ),
        ),
        User(
          name: 'Cenk Duran',
          email: 'cekoley@gmail.com',
          messages: [
            'Hi, I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
          ],
          country: Country(
            countryName: 'Turkey',
            cities: [
              City(
                cityName: 'Ankara',
                countryId: 'TUR',
                activities: [
                  'Visit the Anıtkabir',
                  'Visit the Ankara Castle',
                ],
              ),
            ],
          ),
        ),
        User(
          name: 'Efe Ertürk',
          email: 'efeerturk@gmail.com',
          messages: [
            'Hi, I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
          ],
          country: Country(
            countryName: 'Italy',
            cities: [
              City(
                cityName: 'Turin',
                countryId: 'ITA',
                activities: [
                  'Visit the Mole Antonelliana',
                  'Visit the Egyptian Museum',
                ],
              ),
            ],
          ),
        ),
        User(
          name: 'Efe Şaman',
          email: 'efesaman@gmail.com',
          messages: [
            'Hi, I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
          ],
          country: Country(
            countryName: 'United Kingdom',
            cities: [
              City(
                cityName: 'London',
                countryId: 'GBR',
                activities: [
                  'Visit the Big Ben',
                  'Visit the London Eye',
                ],
              ),
            ],
          ),
        ),
        User(
          name: 'Çağla Ataoğlu',
          email: 'caglaataoglu@gmail.com',
          messages: [
            'Hi, I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
            'I am looking for a travel buddy for my trip to Switzerland.',
          ],
          country: Country(
            countryName: 'Germany',
            cities: [
              City(
                cityName: 'Berlin',
                countryId: 'DEU',
                activities: [
                  'Visit the Brandenburg Gate',
                  'Visit the Berlin Wall',
                ],
              ),
            ],
          ),
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
      imageUrl: 'assets/images/travel_groups/travel_group_1.jpeg',
      destinations: [
        Destination(
          id: '1',
          country: 'Germany',
          city: 'Berlin',
          description: 'Berlin is the largest city in Germany',
          imageUrl: 'assets/images/destinations/destination_4.jpeg',
          rating: 4.5,
          location: 'Europe',
          activities: [
            'Berlin Zoo',
            'Berlin Museum of Art',
            'Berlin Botanical Garden',
            'Berlin Cathedral',
            'Berlin Opera House',
            'Berlin Lake',
          ],
          isPopular: false,
        ),
      ],
    ),
  ];

  List<TravelGroup> get travelGroups {
    return [..._travelGroups];
  }
}

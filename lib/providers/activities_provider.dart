import 'package:flutter/material.dart';
import 'package:travela_mobile/models/activity.dart';

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _activities = [
    Activity(
      id: '1',
      name: 'Eiffel Tower',
      imageUrl: 'assets/images/activities/activity_1.jpeg',
      destinationId: '1',
    ),
    Activity(
      id: '2',
      name: 'Louvre Museum',
      imageUrl: 'assets/images/activities/activity_2.jpeg',
      destinationId: '1',
    ),
    Activity(
      id: '3',
      name: 'Notre Dame Cathedral',
      imageUrl: 'assets/images/activities/activity_3.jpeg',
      destinationId: '1',
    ),
    Activity(
      id: '4',
      name: 'Arc de Triomphe',
      imageUrl: 'assets/images/activities/activity_4.jpeg',
      destinationId: '1',
    ),
    Activity(
      id: '5',
      name: 'Champs-Élysées',
      imageUrl: 'assets/images/activities/activity_5.jpeg',
      destinationId: '1',
    ),
    Activity(
      id: '6',
      name: 'Seine River',
      imageUrl: 'assets/images/activities/activity_6.jpeg',
      destinationId: '1',
    ),
    Activity(
      id: '7',
      name: 'Big Ben',
      imageUrl: 'assets/images/activities/activity_7.jpeg',
      destinationId: '2',
    ),
    Activity(
      id: '8',
      name: 'Tower Bridge',
      imageUrl: 'assets/images/activities/activity_8.jpeg',
      destinationId: '2',
    ),
    Activity(
      id: '9',
      name: 'London Eye',
      imageUrl: 'assets/images/activities/activity_9.jpeg',
      destinationId: '2',
    ),
    Activity(
      id: '10',
      name: 'Buckingham Palace',
      imageUrl: 'assets/images/activities/activity_10.jpeg',
      destinationId: '2',
    ),
    Activity(
      id: '11',
      name: 'Westminster Abbey',
      imageUrl: 'assets/images/activities/activity_11.jpeg',
      destinationId: '2',
    ),
    Activity(
      id: '12',
      name: 'Trafalgar Square',
      imageUrl: 'assets/images/activities/activity_12.jpeg',
      destinationId: '2',
    ),
    Activity(
      id: '13',
      name: 'Statue of Liberty',
      imageUrl: 'assets/images',
      destinationId: '3',
    ),
    Activity(
      id: '14',
      name: 'Empire State Building',
      imageUrl: 'assets/images/activities/activity_14.jpeg',
      destinationId: '3',
    ),
    Activity(
      id: '15',
      name: 'Central Park',
      imageUrl: 'assets/images/activities/activity_15.jpeg',
      destinationId: '3',
    ),
    Activity(
      id: '16',
      name: 'Times Square',
      imageUrl: 'assets/images/activities/activity_16.jpeg',
      destinationId: '3',
    ),
    Activity(
      id: '17',
      name: 'Brooklyn Bridge',
      imageUrl: 'assets/images/activities/activity_17.jpeg',
      destinationId: '3',
    ),
    Activity(
      id: '18',
      name: 'Rockefeller Center',
      imageUrl: 'assets/images/activities/activity_18.jpeg',
      destinationId: '3',
    ),
    Activity(
      id: '19',
      name: 'Sydney Opera House',
      imageUrl: 'assets/images/activities/activity_19.jpeg',
      destinationId: '4',
    ),
    Activity(
      id: '20',
      name: 'Sydney Harbour Bridge',
      imageUrl: 'assets/images/activities/activity_20.jpeg',
      destinationId: '4',
    ),
    Activity(
      id: '21',
      name: 'Bondi Beach',
      imageUrl: 'assets/images/activities/activity_21.jpeg',
      destinationId: '4',
    ),
    Activity(
      id: '22',
      name: 'Sydney Tower',
      imageUrl: 'assets/images/activities/activity_22.jpeg',
      destinationId: '4',
    ),
    Activity(
      id: '23',
      name: 'Royal Botanic Gardens',
      imageUrl: 'assets/images/activities/activity_23.jpeg',
      destinationId: '4',
    ),
    Activity(
      id: '24',
      name: 'Sydney Harbour',
      imageUrl: 'assets/images/activities/activity_24.jpeg',
      destinationId: '4',
    ),
    Activity(
      id: '25',
      name: 'Great Wall of China',
      imageUrl: 'assets/images/activities/activity_25.jpeg',
      destinationId: '5',
    ),
    Activity(
      id: '26',
      name: 'Forbidden City',
      imageUrl: 'assets/images/activities/activity_26.jpeg',
      destinationId: '5',
    ),
  ];

  List<Activity> get activities {
    return [..._activities];
  }

  List<Activity> getActivitiesByDestinationId(String destinationId) {
    return _activities.where((activity) {
      return activity.destinationId == destinationId;
    }).toList();
  }

  Activity getActivityById(String id) {
    return _activities.firstWhere((activity) {
      return activity.id == id;
    });
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void updateActivity(String id, Activity activity) {
    final activityIndex = _activities.indexWhere((activity) {
      return activity.id == id;
    });
    _activities[activityIndex] = activity;
    notifyListeners();
  }
}

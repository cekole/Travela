import 'package:travela_mobile/models/activity.dart';

class Destination {
  final String id;
  final String country;
  final String city;
  final String description;
  final String imageUrl;
  final double rating;
  final String location;
  final List<String> activities;
  bool isPopular;
  //final List<String> images;

  Destination({
    required this.id,
    required this.country,
    required this.city,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.activities,
    required this.isPopular,
    //required this.images,
  });
}

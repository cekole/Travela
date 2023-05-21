class City {
  final String id;
  final String cityName;
  final String countryName;
  final String description;
  final String imageUrl;
  final List<String> activities; //List<ActivityType> activities;
  final String iataCode;
  final double latitude;
  final double longitude;

  City({
    required this.description,
    required this.imageUrl,
    required this.id,
    required this.cityName,
    required this.countryName,
    required this.activities,
    required this.iataCode,
    required this.latitude,
    required this.longitude,
  });
}

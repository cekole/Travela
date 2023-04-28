class City {
  final String id;
  final String cityName;
  final String countryName;
  final List<String> activities; //List<ActivityType> activities;
  final String iataCode;

  City({
    required this.id,
    required this.cityName,
    required this.countryName,
    required this.activities,
    required this.iataCode,
  });
}

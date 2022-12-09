import 'package:travela_mobile/models/city.dart';

class Country {
  final String countryName;
  final List<City> cities; //List<Long> cities;

  Country({
    required this.countryName,
    required this.cities,
  });
}

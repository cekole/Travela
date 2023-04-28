import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/user.dart';

User currentUser = User(
  id: '',
  name: '',
  email: '',
  messages: [],
  country: Country(
    countryName: 'Turkey',
    cities: [],
  ),
);
String baseUrl = "http://localhost:8081/";
String amadeusBearer = '';
String bearerToken = '';

import 'package:travela_mobile/models/country.dart';

class User {
  final String name;
  final String email;
  final List<String> messages;
  final Country country;

  User({
    required this.name,
    required this.email,
    required this.messages,
    required this.country,
  });
}

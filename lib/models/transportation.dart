import 'package:travela_mobile/models/city.dart';

class Transportation {
  final String id;
  final City startCity;
  final City endCity;
  final String transportationType;
  final String link;
  final int price;
  final DateTime startDate; //private Instant start;
  final Duration duration;

  Transportation({
    required this.id,
    required this.startCity,
    required this.endCity,
    required this.transportationType,
    required this.link,
    required this.price,
    required this.startDate,
    required this.duration,
  });
}

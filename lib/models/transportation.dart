import 'package:travela_mobile/models/city.dart';

class Transportation {
  final String id;
  final String startCityId;
  final String endCityId;
  final String transportationType;
  final String link;
  final int price;
  final DateTime? startDate; //private Instant start;
  final int duration;

  Transportation({
    required this.id,
    required this.startCityId,
    required this.endCityId,
    required this.transportationType,
    required this.link,
    required this.price,
    required this.startDate,
    required this.duration,
  });
}

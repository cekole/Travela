import 'package:travela_mobile/models/accomodation.dart';

class Trip {
  String id;
  String period;
  List<String> locations;
  String name;
  List<String> travelGroup;
  Accomodation accomodation;
  String description;
  String transportation;

  Trip({
    required this.id,
    required this.travelGroup,
    required this.transportation,
    required this.period,
    required this.locations,
    required this.name,
    required this.accomodation,
    required this.description,
  });
}

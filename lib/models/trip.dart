import 'package:travela_mobile/models/accomodation.dart';

class Trip {
  String id;
  String period;
  List<String> locations;
  String imageUrl;
  Accomodation accomodation;
  String quickNotes;

  Trip({
    required this.id,
    required this.period,
    required this.locations,
    required this.imageUrl,
    required this.accomodation,
    required this.quickNotes,
  });
}

import 'package:travela_mobile/models/accomodation.dart';
import 'package:travela_mobile/models/travel_group.dart';

class Trip {
  /* 	{
		"trip_id": 1,
		"tripName": "",
		"tripDescription": "",
		"activities": [],
		"travelGroup": {},
		"photos": [],
		"status": "draft",
		"startDate": null,
		"endDate": null
	}, */
  String id;
  String name;
  String description;
  List<String> activities;
  String travelGroup;
  List<String> photos;
  String status;
  DateTime? startDate;
  DateTime? endDate;

  Trip({
    required this.id,
    required this.name,
    required this.description,
    required this.activities,
    required this.travelGroup,
    required this.photos,
    required this.status,
    required this.startDate,
    required this.endDate,
  });
}

class Trip {
  String id;
  String period;
  List<String> locations;
  String imageUrl;
  //TravelGroup travelGroup;
  String accomodation;
  String quickNotes;

  Trip({
    required this.id,
    required this.period,
    required this.locations,
    required this.imageUrl,
    //required this.travelGroup,
    required this.accomodation,
    required this.quickNotes,
  });
}

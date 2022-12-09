class Transportation {
  final String startCity;
  final String endCity;
  final String transportationType; //transportationType enum normali
  final String link;
  final int price;
  final String startDate; //private Instant start;
  final double duration;

  Transportation({
    required this.startCity,
    required this.endCity,
    required this.transportationType,
    required this.link,
    required this.price,
    required this.startDate,
    required this.duration,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({
    Key? key,
    required this.isArranged,
  }) : super(key: key);

  final bool? isArranged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Destinations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                final destinationsData =
                    Provider.of<DestinationsProvider>(context, listen: false);
                destinationsData.getPopularCities();
                Navigator.pushNamed(
                  context,
                  '/popular',
                  arguments: [
                    Set<List<Destination>>.from(
                      [
                        destinationsData.popularDestinationsList.toList(),
                      ],
                    ),
                    false,
                  ],
                );
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: FutureBuilder(
            future: Future.delayed(Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Consumer<DestinationsProvider>(
                builder: (context, destinationsData, child) {
                  if (destinationsData.popularDestinationsList.isEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          destination: 'Loading...',
                          image: 'assets/images/placeholder.png',
                          isArranged: isArranged,
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          destinationsData.popularDestinationsList.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          destination:
                              '${destinationsData.popularDestinationsList[index].city}, ${destinationsData.popularDestinationsList[index].country}',
                          image: destinationsData
                              .popularDestinationsList[index].imageUrl,
                          isArranged: isArranged,
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnswerCard extends StatefulWidget {
  const AnswerCard({
    super.key,
    required this.destination,
    required this.onSelect,
  });

  final Destination destination;
  final Function(Destination) onSelect;

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onSelect(widget.destination);
        });
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        ),
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.destination.imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.destination.city}, ${widget.destination.country}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

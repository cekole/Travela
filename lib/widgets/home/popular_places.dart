import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
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
                Navigator.pushNamed(context, '/popular', arguments: {
                  destinationsData.popularDestinationsList.toList(),
                });
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
                              '${destinationsData.popularDestinationsList[index].city}, ${destinationsData.destinations[index].country}',
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

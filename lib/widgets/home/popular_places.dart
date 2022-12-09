import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final destinationsData = Provider.of<DestinationsProvider>(context);
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
                Navigator.pushNamed(context, '/popular');
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinationsData.destinations.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                destination:
                    '${destinationsData.destinations[index].city}, ${destinationsData.destinations[index].country}',
                image: destinationsData.destinations[index].imageUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/destinations.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class SuggestionsForYou extends StatelessWidget {
  const SuggestionsForYou({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final destinationsData = Provider.of<Destinations>(context, listen: false);
    //TODO: Get the destinations from suggestions, ml model, etc.
    final suggestedDestinations =
        destinationsData.destinations.skip(2).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suggestions For You',
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestedDestinations.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                destination:
                    '${suggestedDestinations[index].city}, ${suggestedDestinations[index].country}',
                image: suggestedDestinations[index].imageUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}

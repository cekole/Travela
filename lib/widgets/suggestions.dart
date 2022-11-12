import 'package:flutter/material.dart';
import 'package:travela_mobile/widgets/place_card.dart';

class SuggestionsForYou extends StatelessWidget {
  const SuggestionsForYou({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PlaceCard(
                  destination: 'Basel, Switzerland',
                  image: 'assets/images/basel.jpg'),
              PlaceCard(
                  destination: 'Venice, Italy',
                  image: 'assets/images/venice.jpg'),
              PlaceCard(
                  destination: 'Paris, France',
                  image: 'assets/images/destinations/destination_1.jpeg'),
            ],
          ),
        ),
      ],
    );
  }
}

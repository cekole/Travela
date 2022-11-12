import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travela_mobile/widgets/place_card.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PlaceCard(
                destination: 'Paris, France',
                image: 'assets/images/destinations/destination_1.jpeg',
              ),
              PlaceCard(
                destination: 'London, UK',
                image: 'assets/images/destinations/destination_2.jpeg',
              ),
              PlaceCard(
                destination: 'New York, USA',
                image: 'assets/images/destinations/destination_3.jpeg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

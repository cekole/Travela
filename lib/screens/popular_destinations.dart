import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/widgets/place_card.dart';
import 'package:travela_mobile/widgets/popular_places.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Favorite Destinations'),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                height: MediaQuery.of(context).size.height * 0.25,
                child: PlaceCard(
                  destination: 'Paris, France',
                  image: 'assets/images/destinations/destination_1.jpeg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Paris is the capital city of France',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                height: MediaQuery.of(context).size.height * 0.25,
                child: PlaceCard(
                  destination: 'London, UK',
                  image: 'assets/images/destinations/destination_2.jpeg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'London is the capital city of the UK',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                height: MediaQuery.of(context).size.height * 0.25,
                child: PlaceCard(
                  destination: 'New York, USA',
                  image: 'assets/images/destinations/destination_3.jpeg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'New York is the capital city of USA',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

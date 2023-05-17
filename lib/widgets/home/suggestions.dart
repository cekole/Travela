import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

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
                final userData =
                    Provider.of<UserProvider>(context, listen: false);
                userData.getTripSuggestions(userId);
                List<Destination> suggestedDestinations =
                    userData.suggestedDestinations;
                Set<List<Destination>> destinationSet = {};
                destinationSet.add(suggestedDestinations);
                Navigator.pushNamed(
                  context,
                  '/popular',
                  arguments: destinationSet,
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .getTripSuggestions(userId),
              builder: (context, snapshot) {
                return Consumer<UserProvider>(
                  builder: (context, userData, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userData.suggestedDestinations.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          destination:
                              '${userData.suggestedDestinations[index].city}, ${userData.suggestedDestinations[index].country}',
                          image: userData.suggestedDestinations[index].imageUrl,
                        );
                      },
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}

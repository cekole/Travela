import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class SuggestionsForGroup extends StatelessWidget {
  const SuggestionsForGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupData = Provider.of<GroupProvider>(context, listen: true);
    //groupData.getTripSuggestions(currentGroupIdForSuggestions);
    List<Destination> suggestedDestinations = groupData.groupTripSuggestions;
    Set<List<Destination>> destinationSet = {};
    destinationSet.add(suggestedDestinations);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suggestions For Group',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: groupData.groupTripSuggestions.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                destination:
                    '${groupData.groupTripSuggestions[index].city}, ${groupData.groupTripSuggestions[index].country}',
                image: groupData.groupTripSuggestions[index].imageUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}

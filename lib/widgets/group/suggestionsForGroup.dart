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
              'Suggestions For Group',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: FutureBuilder(
              future: Provider.of<GroupProvider>(context, listen: false)
                  .getTripSuggestions(currentGroupIdForSuggestions),
              builder: (context, snapshot) {
                return Consumer<GroupProvider>(
                  builder: (context, groupData, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: groupData.groupTripSuggestions.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          destination:
                              '${groupData.groupTripSuggestions[index].city}, ${groupData.groupTripSuggestions[index].country}',
                          image: groupData.groupTripSuggestions[index].imageUrl,
                          isArranged: isArranged,
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

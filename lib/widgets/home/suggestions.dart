import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';

class SuggestionsForYou extends StatelessWidget {
  const SuggestionsForYou({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupData = Provider.of<GroupProvider>(context, listen: true);
    groupData.getTripSuggestions(userId);
    print(currentSuggestions);

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
            itemCount: currentSuggestions.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                destination:
                    '${currentSuggestions[index].city}, ${currentSuggestions[index].country}',
                image: currentSuggestions[index].imageUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}

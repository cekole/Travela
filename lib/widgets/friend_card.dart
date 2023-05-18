import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    required this.title,
    required this.friendNames,
    required this.friendIds,
  }) : super(key: key);

  final String? title;
  final List friendNames;
  final List friendIds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTileCard(
        onExpansionChanged: (value) async {
          final userData = Provider.of<UserProvider>(context, listen: false);
          await userData.getAllFriends();
        },
        baseColor: Color.fromARGB(255, 215, 213, 213).withOpacity(0.5),
        title: Text(title!),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: friendNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(friendNames[index]),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.travel_explore),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTileCard(
        baseColor: Theme.of(context).backgroundColor.withOpacity(0.5),
        title: Text(title!),
        children: [
          Builder(builder: (context) {
            return ListTile(
              title: Text('Yağmur Eryılmaz'),
              subtitle: Text('Sevilla, Spain'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.travel_explore),
              ),
            );
          }),
        ],
      ),
    );
  }
}

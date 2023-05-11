import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:travela_mobile/appConstant.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
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
            print(currentUser.incomingFriendRequests);
            return ListTile(
              title: Text('Ahmet Yılmaz'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

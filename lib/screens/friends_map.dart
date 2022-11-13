import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/widgets/maps/extended_friends_map.dart';

class FriendsMap extends StatelessWidget {
  const FriendsMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends Map'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: ExtendedFriendsMap(),
      ),
    );
  }
}

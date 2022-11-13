import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong2/latlong.dart";
import 'package:travela_mobile/widgets/maps/extended_friends_map.dart';

class FriendsMapBody extends StatefulWidget {
  const FriendsMapBody({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendsMapBody> createState() => _FriendsMapBodyState();
}

class _FriendsMapBodyState extends State<FriendsMapBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).primaryColor,
              ),
              child: ExtendedFriendsMap(),
            ),
          ),
          Text(
            'Friends',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

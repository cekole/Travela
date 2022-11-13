import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong2/latlong.dart";
import 'package:travela_mobile/widgets/maps/extended_friends_map.dart';
import 'package:travela_mobile/widgets/maps/extended_previous_trips_map.dart';

class PreviousTripsMapBody extends StatefulWidget {
  const PreviousTripsMapBody({
    Key? key,
  }) : super(key: key);

  @override
  State<PreviousTripsMapBody> createState() => _PreviousTripsMapBodyState();
}

class _PreviousTripsMapBodyState extends State<PreviousTripsMapBody> {
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
              child: ExtendedPreviousTripsMap(),
            ),
          ),
          Text(
            'My Previous Trips',
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

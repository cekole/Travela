import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

class ExtendedFriendsMap extends StatelessWidget {
  const ExtendedFriendsMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(39.925533, 32.866287),
        zoom: 3.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(39.925533, 32.866287),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(39.925533, 32.836285),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.509865, -0.118092),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(7.509865, 0.018092),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

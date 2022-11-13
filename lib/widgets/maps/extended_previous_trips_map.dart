import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

class ExtendedPreviousTripsMap extends StatelessWidget {
  const ExtendedPreviousTripsMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(37.925533, 26.866287),
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
                  point: LatLng(31.925533, 26.866287),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(49.925533, 22.836285),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(31.509865, -0.518092),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(17.509865, 0.018092),
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

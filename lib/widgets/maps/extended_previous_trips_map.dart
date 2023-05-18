import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import 'package:travela_mobile/appConstant.dart';

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
            center:
                LatLng(currentVisitedCities[0][0], currentVisitedCities[0][1]),
            zoom: 4.5,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              keepBuffer: 20,
            ),
            MarkerLayerOptions(
              markers: [
                for (var i = 0; i < currentVisitedCities.length; i++)
                  //marker with modal
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(
                      currentVisitedCities[i][0],
                      currentVisitedCities[i][1],
                    ),
                    builder: (ctx) => Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    currentVisitedCities[i][2],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    currentVisitedCities[i][3],
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
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

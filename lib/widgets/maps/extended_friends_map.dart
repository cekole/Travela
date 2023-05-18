import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import 'package:travela_mobile/appConstant.dart';

class ExtendedFriendsMap extends StatelessWidget {
  const ExtendedFriendsMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
          currentFriendsVisitedCities[0][0],
          currentFriendsVisitedCities[0][1],
        ),
        zoom: 4.5,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            for (var i = 0; i < currentFriendsVisitedCities.length; i++)
              //marker with modal
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                  currentFriendsVisitedCities[i][0],
                  currentFriendsVisitedCities[i][1],
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
                                currentFriendsVisitedCities[i][2],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                currentFriendsVisitedCities[i][3],
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
    );
  }
}

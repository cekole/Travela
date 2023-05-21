import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import "package:latlong2/latlong.dart";
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/file_storage_provider.dart';

class ExtendedPreviousTripsMap extends StatefulWidget {
  const ExtendedPreviousTripsMap({
    Key? key,
  }) : super(key: key);

  @override
  State<ExtendedPreviousTripsMap> createState() =>
      _ExtendedPreviousTripsMapState();
}

class _ExtendedPreviousTripsMapState extends State<ExtendedPreviousTripsMap> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

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
                                    Row(children: [
                                      TextButton(
                                        onPressed: () {
                                          pickImage().then((value) {
                                            final fileStorageData = Provider.of<
                                                    FileStorageProvider>(
                                                context,
                                                listen: false);
                                            if (image != null) {
                                              fileStorageData
                                                  .uploadPhotoToTripLocation(
                                                      image!.path,
                                                      currentTripId,
                                                      '2');
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/home',
                                                      (route) => false);
                                              pageNum = 4;
                                            }
                                          });
                                        },
                                        child: Text(
                                          'Post Photo',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          // add icon
                                        ),
                                      ),
                                      Spacer(),
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
                                    ]),
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

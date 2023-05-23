import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import "package:latlong2/latlong.dart";
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/trip.dart';
import 'package:travela_mobile/providers/file_storage_provider.dart';
import 'package:travela_mobile/providers/trip_provider.dart';

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
  late List<Uint8List> photoDataList; // List to store photo data

  Future<void> pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<List<Uint8List>> getPhotos(List<String> tripIds) async {
    List<Uint8List> dataList = [];
    final tripData = Provider.of<TripProvider>(context, listen: false);
    final fileStorageData =
        Provider.of<FileStorageProvider>(context, listen: false);
    for (var tripId in tripIds) {
      final trip = await tripData.getById(tripId);

      if (trip != null && trip.photos != null) {
        for (var photo in trip.photos) {
          if (photo != null) {
            final photoData = await fileStorageData.getFile(photo);

            if (photoData is Uint8List) {
              dataList.add(photoData);
            }
          }
        }
      }
    }

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve necessary data providers
    final tripData = Provider.of<TripProvider>(context, listen: false);
    final fileStorageData =
        Provider.of<FileStorageProvider>(context, listen: false);

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
                        onPressed: () async {
                          final String currentCityName =
                              currentVisitedCities[i][2];
                          var selectedLocationIds = <String>[];
                          var selectedTripIds = <String>[];
                          var selectedTripId = '';
                          var selectedLocationId = '';

                          final trips = await tripData.getAll();
                          for (var trip in trips) {
                            final locations =
                                await tripData.getLocationsByTripId(trip.id);
                            for (var location in locations) {
                              if (location['locationName']
                                      .toString()
                                      .toLowerCase() ==
                                  currentCityName.toLowerCase()) {
                                selectedLocationId =
                                    location['location_id'].toString();
                                selectedTripId =
                                    location['trip']['trip_id'].toString();
                                print(selectedTripId);
                                print(selectedLocationId);
                                selectedLocationIds
                                    .add(location['location_id'].toString());
                                selectedTripIds.add(
                                    location['trip']['trip_id'].toString());
                              }
                            }
                          }
                          print('out');
                          print(selectedLocationId);
                          print(selectedTripId);

                          photoDataList = [];

                          for (var tripId in selectedTripIds) {
                            final trip = await tripData.getById(tripId);

                            if (trip != null && trip.photos != null) {
                              for (var photo in trip.photos) {
                                if (photo != null) {
                                  final photoData =
                                      await fileStorageData.getFile(photo);

                                  if (photoData is Uint8List) {
                                    photoDataList.add(photoData);
                                  }
                                }
                              }
                            }
                          }

                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      currentVisitedCities[i][2],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          pickImage().then((value) async {
                                            if (image != null) {
                                              await fileStorageData
                                                  .uploadPhotoToTripLocation(
                                                image!.path,
                                                selectedTripId,
                                                selectedLocationId,
                                              )
                                                  .then((value) {
                                                if (value!) {
                                                  Theme.of(context).platform ==
                                                          TargetPlatform.iOS
                                                      ? showCupertinoDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CupertinoAlertDialog(
                                                              title: Text(
                                                                  'Success'),
                                                              content: Text(
                                                                  'Photo uploaded successfully'),
                                                              actions: [
                                                                CupertinoDialogAction(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      : showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Success'),
                                                              content: Text(
                                                                  'Photo uploaded successfully'),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                } else {
                                                  Theme.of(context).platform ==
                                                          TargetPlatform.iOS
                                                      ? showCupertinoDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CupertinoAlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text(
                                                                  'Photo upload failed'),
                                                              actions: [
                                                                CupertinoDialogAction(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      : showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text(
                                                                  'Photo upload failed'),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                }
                                              });
                                            }
                                          });
                                        },
                                        child: Text(
                                          'Post Photo',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    photoDataList.isEmpty
                                        ? Text('No photos yet')
                                        : SizedBox(
                                            height: 150,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(width: 15),
                                              itemCount: photoDataList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: EdgeInsets.all(5),
                                                  margin: EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Image.memory(
                                                    photoDataList[index],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                          );
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

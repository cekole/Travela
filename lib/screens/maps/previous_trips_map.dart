import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/file_storage_provider.dart';
import 'package:travela_mobile/widgets/maps/extended_friends_map.dart';
import 'package:travela_mobile/widgets/maps/extended_previous_trips_map.dart';

class PreviousTripsMap extends StatefulWidget {
  const PreviousTripsMap({Key? key}) : super(key: key);

  @override
  State<PreviousTripsMap> createState() => _PreviousTripsMapState();
}

class _PreviousTripsMapState extends State<PreviousTripsMap> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Trips Map'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ExtendedPreviousTripsMap(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.filter_list),
                label: Text('Options'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SafeArea(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Add Photos'),
                              leading: Icon(Icons.add_a_photo),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                pickImage().then((value) {
                                  final fileStorageData =
                                      Provider.of<FileStorageProvider>(context,
                                          listen: false);
                                  if (image != null) {
                                    fileStorageData
                                        .uploadPhotoToTripLocation(
                                            image!.path, currentTripId, '6')
                                        .then((value) =>
                                            Navigator.of(context).pop());

                                    pageNum = 4;
                                  }
                                });
                              },
                            ),
                            ListTile(
                              title: Text('Rate'),
                              leading: Icon(Icons.star),
                              trailing: DropdownButton(
                                value: 5,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('1'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('2'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('3'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('4'),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('5'),
                                    value: 5,
                                  ),
                                ],
                                onChanged: (value) {},
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
          ],
        ),
      ),
    );
  }
}

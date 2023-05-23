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
        title: Text('Visited Cities Map'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ExtendedPreviousTripsMap(),
          ],
        ),
      ),
    );
  }
}

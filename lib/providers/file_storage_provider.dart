import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;
import 'package:travela_mobile/models/city.dart';
import 'package:travela_mobile/models/country.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/models/user.dart';

class FileStorageProvider with ChangeNotifier {
  Future<void> uploadProfilePic(String filePath, String uId) async {
    final url = baseUrl + 'files/uploadProfilePicToUser/$uId';
    print(url);
    final response = http.MultipartRequest('POST', Uri.parse(url));

    var file = File(filePath);
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: file.path,
    );

    response.files.add(multipartFile);

    final res = await response.send();
    print(res.statusCode);

    if (res.statusCode == 200) {
      print('uploadProfilePic success');
    } else {
      print('uploadProfilePic failed');
    }
  }

  Future<void> getProfilePic(String uId) async {
    final url = baseUrl + 'files/getProfilePic/$uId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    final extractedData = json.decode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return;
    }
    profilePic = extractedData[0]['profilePic'];
  }

// request param diye bir şey var o nasıl olcaka ona bak
  Future<void> uploadPhotoToTripLocation(String uId, String locationId) async {
    final url = baseUrl + 'files/uploadPhotoToTrip/$uId/ToLocation/$locationId';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('uploadProfilePic success');
      return json.decode(response.body);
    } else {
      print('uploadProfilePic failed');
    }
  }

  Future<void> getPhotosOfTrip(String tripId) async {
    final url = baseUrl + 'files/getProfilePic/$tripId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    final extractedData = json.decode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((element) {
      tripPhotos.add(element['tripPhotos']); // adı trip photos değil bak!!!!!
    });
  }
}

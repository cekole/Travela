import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
  Uint8List? _profilePic;
  Uint8List? _tripPhoto;

  Uint8List? get profilePic => _profilePic;

  Uint8List? get tripPhoto => _tripPhoto;

  Future<Uint8List> getFile(String fileName) async {
    final url = baseUrl + 'files/$fileName';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      _tripPhoto = response.bodyBytes;
      notifyListeners();
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch profile picture');
    }
  }

  Future<void> uploadProfilePic(String filePath, String uId) async {
    final url = baseUrl + 'files/uploadProfilePicToUser/$uId';
    print(url);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = 'Bearer $bearerToken';

    var file = await http.MultipartFile.fromPath('file', filePath);
    request.files.add(file);

    try {
      var response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        _profilePic = await response.stream.toBytes();
        notifyListeners();
        print('uploadProfilePic success');
      } else {
        print('uploadProfilePic failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool?> uploadPhotoToTripLocation(
      String filePath, String tripId, String locationId) async {
    final url =
        baseUrl + 'files/uploadPhotoToTrip/$tripId/ToLocation/$locationId';
    print(url);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = 'Bearer $bearerToken';

    var file = await http.MultipartFile.fromPath('file', filePath);
    request.files.add(file);

    try {
      var response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('uploadPhotoToTripLocation success');
        return true;
      } else {
        print('uploadPhotoToTripLocation failed');
        return false;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Uint8List> fetchProfilePic(String uId) async {
    final url = baseUrl + 'files/getProfilePic/$uId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      _profilePic = response.bodyBytes;
      notifyListeners();
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch profile picture');
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

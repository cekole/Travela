import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;

import 'package:travela_mobile/models/poll_option.dart';

class MessageProvider with ChangeNotifier {
  Future<void> addGPoll(List<PollOption> options) async {
    final url = baseUrl + 'messages/poll';
    print(url);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer  $bearerToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {'options': options},
        ));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('addGPoll succeeded');
      return json.decode(response.body);
    } else {
      print('addGPoll failed');
    }
  }

  Future<void> get(String uId) async {
    final url = baseUrl + 'groups/user/$uId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('getGroupByUserId succeeded');
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }
      currentGroupId = extractedData.last['group_id'].toString();
      print('currentGroupId');
      print(currentGroupId);

      notifyListeners();

      return json.decode(response.body);
    } else {
      print('getGroupByUserId failed');
    }
  }
}

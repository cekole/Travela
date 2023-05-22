import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:http/http.dart' as http;

import 'package:travela_mobile/models/poll_option.dart';

class MessageProvider with ChangeNotifier {
  Future<void> addPoll(List<PollOption> options) async {
    final url = baseUrl + 'messages/poll';
    final pollOptions = options
        .map((option) => {
              'content': option.content,
              'votes': option.votes,
            })
        .toList();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'pollOptions': pollOptions,
      }),
    );

    if (response.statusCode == 200) {
      print('addPoll succeeded');
      return json.decode(response.body);
    } else {
      print('addPoll failed');
    }
  }

  Future<void> addPollOption(String id, PollOption pollOptionDTO) async {
    final url = '$baseUrl/poll/$id/option';
    final response = await http.put(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer  $bearerToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(pollOptionDTO));
    if (response.statusCode != 200) {
      throw Exception('Failed to add poll option');
    }
  }

  Future<void> votePollOption(String id, String optionId) async {
    final url = '$baseUrl/poll/$id/vote/$optionId';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to vote poll option');
    }
  }

  Future<void> getPollByUserId(String id) async {
    final url = '$baseUrl/poll/getByUserId/$id';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer  $bearerToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to get polls by user ID');
    }
  }

  Future<void> deleteMessage(String id) async {
    final url = '$baseUrl/$id';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete message');
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
      print('getByUserId succeeded');
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
      print('getByUserId failed');
    }
  }
}

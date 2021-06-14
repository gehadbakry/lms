import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/NotificationModels.dart';
class NotificationAllCount{
  var response;
  Future<AllCount>getAllNotificationCount(int SCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/NotificationApi/GetNotificatioAllCount?user_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("all not count ${response.body}");
      return  AllCount.fromJson(
        json.decode(response.body),
      );
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
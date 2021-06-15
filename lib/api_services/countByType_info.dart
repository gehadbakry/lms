import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/NotificationModels.dart';
class NotificationCountByType{
  var response;
  Future<countByType>getCountByType(int SCode , var NotType ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/NotificationApi/GetNotificationCountByType?user_code=$SCode&notification_type_code=$NotType");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("type count ${response.body}");
      return  countByType.fromJson(
        json.decode(response.body),
      );
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
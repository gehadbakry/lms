import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/ChatUsers.dart';

class ChatUserInfo{
  var response;
  Future<List<ChatUsers>>getChatUsers(int SCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/StudentApi/GetUsersChat?studentCode=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("chat data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<ChatUsers>((json) => ChatUsers.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}

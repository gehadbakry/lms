import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/selectedChat.dart';

class SelectedChatInfo{
  var response;
  Future<List<SelectedChat>>getSelectedChat(int userLogedin , int userSelected) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/StudentApi/GetSelectedChat?user_logedin=$userLogedin&user_selected=$userSelected");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("selected chat data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<SelectedChat>((json) => SelectedChat.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}

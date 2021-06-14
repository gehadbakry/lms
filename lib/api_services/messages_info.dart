import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/messages.dart';
import 'dart:convert';


class SendMessage {
  var response;
  Future<http.Response> sendMessage(Messages messageModel) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/chatApi/PostChat");

    response = await http.post(url, body: messageModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400 ||response.statusCode == 201||response.statusCode == 204 ) {
      print("Login data ${response.body}");
      return response;
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
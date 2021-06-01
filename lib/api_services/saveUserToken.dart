import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/userTokenInfo.dart';
import 'dart:convert';


class SaveUserToken with ChangeNotifier{
  var response;
  Future<UserToken> Usertoken(UserToken user) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/LoginApi/PostUserTockenID");

    response = await http.post(url, body: user.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Login data ${response.body}");
      notifyListeners();
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/editProfileData.dart';
import 'dart:convert';

class EditMyProfile {
  var response;
  var map = Map<String,dynamic>();
  Future<http.Response> EditProfileData(EditProfile changePasswordModel) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/LoginApi/PostUserEditPeofile");
    response = await http.post(url, body:changePasswordModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 201 ||response.statusCode == 204) {
      print("pass data");
      return response;
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
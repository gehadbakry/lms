import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/login_model.dart';
import 'dart:convert';


class APIService with ChangeNotifier{
  LoginResponseModel loginResponse;
  var response;
  var usertype;
  var children;
  var usercode;
  var code;
  var schoolYear;
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/LoginApi/PostCheckUserLogin");

    response = await http.post(url, body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Login data ${response.body}");
      usertype = LoginResponseModel.fromJson(json.decode(response.body),).userType;
      children = LoginResponseModel.fromJson(json.decode(response.body),).childrenCode;
      usercode = LoginResponseModel.fromJson(json.decode(response.body),).userCode;
      code = LoginResponseModel.fromJson(json.decode(response.body),).code;
      schoolYear =LoginResponseModel.fromJson(json.decode(response.body),).schoolYearCode;
      notifyListeners();
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
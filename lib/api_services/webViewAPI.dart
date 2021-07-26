import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/webViewLink.dart';
import 'dart:convert';


class WebViewApi {
  var response;
  WebViewPost webViewPost;

  Future<dynamic> webLink(WebViewPost requestModel) async {
    Uri url = Uri.parse(
        "http://169.239.39.105/lms_api2/api/StudentApi/loginOnlineExam?uc=${requestModel
            .userCode}&examCode=${requestModel.examCode}");

    response = await http.post(url, body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      print(" ${response.body}");
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

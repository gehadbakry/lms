import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/assignmentFile.dart';
class Assignmentfile{
  var response;
  Future<List<AssignmentFile>>getAssignmentFile(int SCode,int assignCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/StudentApi/GetAssignmentFile?assignment_code=$assignCode&student_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("assign file path ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<AssignmentFile>((json) => AssignmentFile.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
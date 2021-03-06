import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';


class StudentData with ChangeNotifier{
  Student student;
  var response;
  var NameAr;
  var NameEn;
  var studentcode;
  List studentData;
  Future<Student> SData(int SCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/GetStudentProfile?student_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
     print("student data ${response.body}");
      NameAr = Student.fromJson(json.decode(response.body),).sNameAR;
      NameEn = Student.fromJson(json.decode(response.body),).sNameEN;
      studentcode = Student.fromJson(json.decode(response.body),).studentCode;
      notifyListeners();
      return  Student.fromJson(
        json.decode(response.body),
      );
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
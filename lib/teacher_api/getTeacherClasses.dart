import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_classes.dart';
class TeacherClassesInfo {
  var response;
  Future<List<TeacherClasses>>getTeacherClassesInfo(int teacherCode , int subjectCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetTeacherClasses?techerCode=$teacherCode&stage_subject_code=$subjectCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher class data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherClasses>((json) => TeacherClasses.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_subjects.dart';
class TeacherSubjectsInfo {
  var response;
  Future<List<TeacherSubjects>>getTeacherSubjectsInfo(int teacherCode ,int schoolYear) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetTeacherSubjects?teacher_code=$teacherCode&sy=$schoolYear");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher subject data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherSubjects>((json) => TeacherSubjects.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
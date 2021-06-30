import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_assignment_model.dart';
class TeacherAssignmentInfo {
  var response;
  Future<List<TeacherAssignment>>getTeacherAssignmentInfo(int teacherCode , int subjectCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetTeacherassignment?teacher_code=$teacherCode&stage_subject_code=$subjectCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher assignment data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherAssignment>((json) => TeacherAssignment.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
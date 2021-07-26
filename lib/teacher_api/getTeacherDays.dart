import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_days.dart';
class TeacherDaysInfo {
  var response;
  Future<List<TeacherDays>>getTeacherDaysInfo(int teacherCode , int schoolyear) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetSchoolScheduelDaysTeacher?teacher_code=$teacherCode&sy=$schoolyear");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher days data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherDays>((json) => TeacherDays.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
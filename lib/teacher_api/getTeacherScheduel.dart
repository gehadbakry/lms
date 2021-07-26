import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_scheduel.dart';
class TeacherScheduelInfo {
  var response;
  Future<List<TeacherScheduel>>getTeacherScheduelInfo(int teacherCode , int schoolyear ,int dayCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetTeacherScheduel?teacher_code=$teacherCode&sy=$schoolyear&day_code=$dayCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher days data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherScheduel>((json) => TeacherScheduel.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
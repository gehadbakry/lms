import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_event_model.dart';
class TeacherEventInfo {
  var response;
  Future<List<TeacherEvent>>getTeacherEventInfo(int teacherCode ,int schoolYear) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetEventsTeacher?teacher_code=$teacherCode&sy=$schoolYear");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher event data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherEvent>((json) => TeacherEvent.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
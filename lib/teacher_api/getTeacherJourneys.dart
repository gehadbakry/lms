import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_journey_model.dart';
class TeacherJourneyInfo {
  var response;
  Future<List<TeacherJourney>>getTeacherJourneyInfo(int teacherCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetTeacherjourny?teacher_code=$teacherCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher journey data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherJourney>((json) => TeacherJourney.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
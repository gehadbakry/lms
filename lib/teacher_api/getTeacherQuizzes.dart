import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_quiz_model.dart';
class TeacherQuizzesInfo {
  var response;
  Future<List<TeacherQuiz>>getTeacherQuizzesInfo(int teacherCode ,int subjectCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetTeacherquiz?teacher_code=$teacherCode&stage_subject_code=$subjectCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher quizzes data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherQuiz>((json) => TeacherQuiz.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
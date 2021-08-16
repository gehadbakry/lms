import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_students_marks.dart';
class TeacherStudentsMarksInfo {
  var response;
  Future<List<StudentsMarksList>>getTeacherStudentsMarksInfo(int quizCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetStudentquiz?quiz_code=$quizCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher days data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<StudentsMarksList>((json) => StudentsMarksList.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
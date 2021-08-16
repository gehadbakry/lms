import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_student_object_list.dart';
class TeacherClassStudentsInfo {
  var response;
  Future<List<StudentInList>>getTeacherClassStudentInfo(int tableCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetStudentAttendance?code=$tableCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher class students data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<StudentInList>((json) => StudentInList.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
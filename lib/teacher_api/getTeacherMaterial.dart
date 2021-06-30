import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/teacher_models/teacher_material_model.dart';
class TeacherMaterialInfo {
  var response;
  Future<List<TeacherMaterial>>getTeacherMaterialInfo(int teacherCode ,int schoolYear , int subjectCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/GetMaterialsTeacher?teacher_code=$teacherCode&sy=$schoolYear&stage_subject_code=$subjectCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Teacher material data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<TeacherMaterial>((json) => TeacherMaterial.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
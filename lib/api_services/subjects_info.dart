import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/subject.dart';
class SubjectInfo {
  var response;
  Future<List<Subject>>getSubjects(int SCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/Getsubjects?stu_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("subject data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
      // return  Subject.fromJson(
      //   json.decode(response.body),
      // );
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
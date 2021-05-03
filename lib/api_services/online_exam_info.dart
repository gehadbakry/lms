import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/online_exam.dart';
class OnlineExamInfo {
  var response;
  Future<List<OnlineExams>>getOnlineExam(int SCode , int subjectCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/GetExam?s_code=$SCode&stage_subject_code=$subjectCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("onlineExam data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<OnlineExams>((json) => OnlineExams.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
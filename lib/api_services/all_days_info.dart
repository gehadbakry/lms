import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/all_days_scheduel.dart';
class AllDaysScheduelInfo {
  var response;
  var quizCode;
  Future<List<AllDaysScheduel>>getAllDays(int SCode , int schoolYear ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/StudentApi/GetSchoolScheduelDays?student_code=$SCode&sy=$schoolYear");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("AllDays data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<AllDaysScheduel>((json) => AllDaysScheduel.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
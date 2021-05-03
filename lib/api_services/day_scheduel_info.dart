import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/day_scheduel.dart';
class DayScheduelInfo {
  var response;
  var quizCode;
  Future<List<DayScheduel>>getDayScheduel(int SCode , int schoolYear , int daycode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/StudentApi/GetSchoolScheduel?student_code=$SCode&sy=$schoolYear&day_code=$daycode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("AllDays data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<DayScheduel>((json) => DayScheduel.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
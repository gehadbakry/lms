import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/student_rank.dart';
class RankInfo {
  var response;
  var quizCode;
  Future<List<Rank>>getRank(int quizcode , int SCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/GetQuiz_Rank?quiz_code=$quizcode&s_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Rank data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<Rank>((json) => Rank.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
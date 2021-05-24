import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/calender_data.dart';

class CalendarInfo {
  var response;
  var AfterParce;
  var parsed;
  static var body;
  Calender calender;
  Future<List<Calender>>getEventsCalendar(int SCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/Get_calendar?s_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      body = response.body;
      print("calender data ${response.body}");
      parsed = jsonDecode(response.body);
     // Map.fromEntries(parsed.map((Calender)=> MapEntry(key, value)));
      return parsed.map<Calender>((json) => Calender.fromJson(json)).toList();
          }
    else{
      throw Exception('Failed to load data!');
    }
  }
  // newMap = groupBy(body, (obj) => obj['violation_date']);
}
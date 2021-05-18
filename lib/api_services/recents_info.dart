import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/recents.dart';
class RecentsInfo{
  var response;
  Future<List<Recents>>getRecents(int userCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/LoginApi/GetRecent?user_code=$userCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Recent data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<Recents>((json) => Recents.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
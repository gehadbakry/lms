import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/notification_data.dart';
class NotificationInfo {
  var response;
  var parsed;
  Future<List<Notifications>>getNotifications(int userCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/LoginApi/GetNotification?user_code=$userCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Notification data ${response.body}");
      parsed = jsonDecode(response.body);
      return parsed.map<Notifications>((json) => Notifications.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
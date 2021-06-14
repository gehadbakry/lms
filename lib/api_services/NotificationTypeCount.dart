import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/NotificationModels.dart';
class NotificationTypeCount {
  var response;
  var parsed;
  Future<List<TypeNotification>>getNotificationsTypeCount(int userCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/api/NotificationApi/GetNotificationTypeCount?user_code=$userCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Notification count ${response.body}");
      parsed = jsonDecode(response.body);
      return parsed.map<TypeNotification>((json) => TypeNotification.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
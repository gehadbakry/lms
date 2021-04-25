import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/bus_data.dart';
class BusInfo{
  var response;
  Future<BusData>getBus(int SCode , int yearcode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/GetBusInfo?s_code=$SCode&sy=$yearcode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Bus data ${response.body}");
      return  BusData.fromJson(
        json.decode(response.body),
      );
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
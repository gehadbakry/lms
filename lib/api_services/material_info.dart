import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/material_data.dart';
class MaterialInfo {
  var response;
  var body;
  Future<List<Materials>>getMaterial(int SCode , int subjectCode ) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/GetMaterials?s_code=$SCode&stage_subject_code=$subjectCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("material data ${response.body}");
      final parsed = jsonDecode(response.body);
      body = response.body;
      return parsed.map<Materials>((json) => Materials.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }
}
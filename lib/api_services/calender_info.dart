import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/calender_data.dart';
import 'package:lms_pro/models/calendar_dateTime.dart';
class CalendarInfo {
  var response;
  Map<DateTime, List> events;
  Future<List<Calender>>getEventsCalendar(int SCode) async {
    Uri url = Uri.parse("http://169.239.39.105/lms_api2/API/StudentApi/Get_calendar?s_code=$SCode");
    response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("calender data ${response.body}");
      final parsed = jsonDecode(response.body);
      return parsed.map<Calender>((json) => Calender.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load data!');
    }
  }

  void eventsToMap(){
    List<CalenderDateTime> convertedToDatetimeList = [];
    for (Calender calendarResponse in response) {
      if (calendarResponse.type == 1) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
            journeyName: calendarResponse.journeyName,
            cost: calendarResponse.cost,
            maxStudent: calendarResponse.maxStudent,
            companionAllowed: calendarResponse.companionAllowed,
            maxCompanion: calendarResponse.maxCompanion,
            dateTo: DateTime.parse(calendarResponse.dateTo),
            dateFrom: DateTime.parse(calendarResponse.dateFrom),
            finalDate: DateTime.parse(calendarResponse.finalDate),
            notes: calendarResponse.notes,
            type: calendarResponse.type
        );
        convertedToDatetimeList.add(calenderDateTime);
      }
      else if (calendarResponse.type == 2) {
        CalenderDateTime calenderDateTime =
        CalenderDateTime(
          absenceDate: DateTime.parse(calendarResponse.absenceDate),
          absenceReasonAr: calendarResponse.absenceReasonAr,
          absenceReasonEn: calendarResponse.absenceReasonEn,
          absenceNote: calendarResponse.absenceNote,
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add( calenderDateTime);
      } else if (calendarResponse.type == 3) {
        CalenderDateTime calenderDateTime =
        CalenderDateTime(
          stageVaccDate:
          DateTime.parse(calendarResponse.stageVaccDate),
          vaccNote: calendarResponse.vaccNote,
          vaccNameAr: calendarResponse.vaccNameAr,
          vaccNameEn: calendarResponse.vaccNameEn,
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime);
      } else if (calendarResponse.type == 4) {
        CalenderDateTime calenderDateTime =
        CalenderDateTime(
          eventNameAr: calendarResponse.eventNameAr,
          eventNameEn: calendarResponse.eventNameEn,
          eventDescAr: calendarResponse.eventDescAr,
          eventDescEn: calendarResponse.eventDescEn,
          eventTime: calendarResponse.eventTime,
          eventCost: calendarResponse.eventCost,
          eventLocation: calendarResponse.eventLocation,
          eventDate: DateTime.parse(calendarResponse.eventDate),
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime );
      } else {
        CalenderDateTime calenderDateTime =
        CalenderDateTime(
          violationNote: calendarResponse.violationNote,
          violationNameAr: calendarResponse.violationNameAr,
          violationNameEn: calendarResponse.violationNameEn,
          violationDate: DateTime.parse(calendarResponse.violationDate),
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add( calenderDateTime);
      }
    }
    Map<DateTime, List<CalenderDateTime>> datetimeGroups =
    groupBy(convertedToDatetimeList, (calenderdatetime) {
      if (calenderdatetime.type == 1) {
        return calenderdatetime.finalDate;
      } else if (calenderdatetime.type == 2) {
        return calenderdatetime.absenceDate;
      } else if (calenderdatetime.type == 3) {
        return calenderdatetime.stageVaccDate;
      } else if (calenderdatetime.type == 4) {
        return calenderdatetime.eventDate;
      } else {
        return calenderdatetime.violationDate;
      }
    });
    events.clear();
    events.addAll(datetimeGroups);
    // bool loading = false.obs;
    // update();
  }
}
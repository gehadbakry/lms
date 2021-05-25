import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/calender_info.dart';
import 'package:lms_pro/models/calendar_dateTime.dart';
import 'package:lms_pro/models/calender_data.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_style.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> with TickerProviderStateMixin {
  CalendarController controller;
  var code;
  Calender calender;
  List selectedEvents;
  static Map<DateTime, List> events;
  AnimationController _animationController;
  DateTime selectedDay;
  //Map<DateTime, List<CalenderDateTime>> datetimeGroups;

  List<CalenderDateTime> convertedToDatetimeList = [];

  @override


  void dispose() {
    controller.dispose();
    super.dispose();
  }
  //FUNCTION CONVERTS THE API RESPONCE TO A MAP TO BE ABLE TO SHOW IT IN THE CALENDAR
  eventsToMap() async {
    List<Calender> calendar =
    await CalendarInfo().getEventsCalendar(int.parse(Provider.of<APIService>(context, listen: false).code));
    for (Calender calendarResponse in calendar) {
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
            type: calendarResponse.type);
        convertedToDatetimeList.add(calenderDateTime);
      }
      else if (calendarResponse.type == 2) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
          absenceDate: DateTime.parse(calendarResponse.absenceDate),
          absenceReasonAr: calendarResponse.absenceReasonAr,
          absenceReasonEn: calendarResponse.absenceReasonEn,
          absenceNote: calendarResponse.absenceNote,
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime);
      }
      else if (calendarResponse.type == 3) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
          stageVaccDate: DateTime.parse(calendarResponse.stageVaccDate),
          vaccNote: calendarResponse.vaccNote,
          vaccNameAr: calendarResponse.vaccNameAr,
          vaccNameEn: calendarResponse.vaccNameEn,
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime);
      }
      else if (calendarResponse.type == 4) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
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
        convertedToDatetimeList.add(calenderDateTime);
      }
      else if (calendarResponse.type == 5) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
          violationNote: calendarResponse.violationNote,
          violationNameAr: calendarResponse.violationNameAr,
          violationNameEn: calendarResponse.violationNameEn,
          violationDate: DateTime.parse(calendarResponse.violationDate),
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime);
      }
    }
    Map<DateTime, List<CalenderDateTime>> datetimeGroups = groupBy(convertedToDatetimeList, (calenderdatetime) {
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
    // events.clear();
    // events.addAll(datetimeGroups);
    setState(() {
      events.clear();
      events.addAll(datetimeGroups);
    });
  }

  void initState() {
    super.initState();
    eventsToMap();
    selectedDay = DateTime.now();
    selectedEvents = [];
    events = {};
    controller = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   eventstToMap.then((val) => setState(() {
    //     events = val;
    //   }));
    //   //print( ' ${_events.toString()} ');
    // });
  }

  @override
  Widget build(BuildContext context) {
    var newheight = (MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
    });

    print( "from build body $events");
    //CUSTOM APP BAR
    Widget myAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BNV()),
            );
          }),
      centerTitle: true,
      title: Text(
        "Events",
        style: AppTextStyle.headerStyle,
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications),
            color: ColorSet.whiteColor,
            iconSize: 25,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifi()),
              );
            })
      ],
    );

    return Scaffold(
      floatingActionButton: ChatButton(),
      backgroundColor: ColorSet.primaryColor,
      appBar: myAppBar,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: _buildTableCalendarWithBuilders(),
          decoration: BoxDecoration(
          color: ColorSet.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: ColorSet.shadowcolour,
              spreadRadius: 4,
              blurRadius: 3,
              offset: Offset(1,3),
            ),
          ]
      ),
          ),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
      ),
    );
  }
  Widget _buildTableCalendarWithBuilders() {
    print( "from build calendar $events");
   return TableCalendar(
      calendarController: controller,
      headerStyle: HeaderStyle(formatButtonVisible: false),
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(color: ColorSet.primaryColor),
        weekendStyle: TextStyle(color: ColorSet.primaryColor),
        outsideWeekendStyle: TextStyle(color: ColorSet.primaryColor),
        holidayStyle: TextStyle(color: ColorSet.primaryColor),
        outsideHolidayStyle: TextStyle(color: ColorSet.primaryColor),
      ),
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.saturday,
      availableGestures: AvailableGestures.all,
      events: events,
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0)
                .animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected:(date, events ,_){
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      } ,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );

  }
  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      selectedEvents = events;
    });
  }
  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }
  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: controller.isSelected(date)
            ? Colors.brown[500]
            : controller.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
      print("selected events ${selectedEvents}");
    return ListView(
      children: selectedEvents.map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  //title: Text(selectedEvents),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/models/calender_data.dart';
import 'package:lms_pro/teacher_api/getTeacherEvents.dart';
import 'package:lms_pro/teacher_models/teacher_event_model.dart';
import 'package:lms_pro/teacher_models/teacher_journey_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TeacherEvents extends StatefulWidget {
  @override
  _TeacherEventsState createState() => _TeacherEventsState();
}

class _TeacherEventsState extends State<TeacherEvents> with TickerProviderStateMixin{
  int code;
  int SchoolYear;
  int subjestStageCode;
  List<TeacherEventsDateTime> EventsToDatetimeList = [];
  static Map<DateTime, List> events;
  CalendarController controller;
  Calender calender;
  List selectedEvents;
  AnimationController _animationController;
  DateTime selectedDay;


  eventToMap()async{
    //List<TeacherEvent> event = await TeacherEventInfo().getTeacherEventInfo(253,5) ;
    List<TeacherEvent> event = await TeacherEventInfo().getTeacherEventInfo(int.parse(Provider.of<APIService>(context, listen: false).code),
        Provider.of<APIService>(context, listen: false).schoolYear) ;
    for (TeacherEvent event in event) {
      TeacherEventsDateTime teacherevent =  TeacherEventsDateTime(
        isPay:event.isPay,
        cancelPermissionDate:DateTime.parse(event.cancelPermissionDate) ,
        subscriptionDate:event.subscriptionDate==null?DateTime.now():DateTime.parse(event.subscriptionDate) ,
        subPermissionDate:event.subPermissionDate==null?DateTime.now(): DateTime.parse(event.subPermissionDate),
        isPaied: event.isPaied,
        isCanceled: event.isCanceled,
        eventNameEN: event.eventNameEN,
        eventNameAR: event.eventNameAR,
        eventImage: event.eventImage,
        eventDescriptionEN: event.eventDescriptionEN,
        eventDescriptionAR: event.eventDescriptionAR,
        divSchoolEventDetail: event.divSchoolEventDetail,
        divCode: event.divCode,
        cancelDate:event.cancelDate==null?DateTime.now(): DateTime.parse(event.cancelDate),
        schoolYearCode: event.schoolYearCode,
        cost: event.cost,
        eventDate:event.eventDate==null?DateTime.now(): DateTime.parse(event.eventDate),
        eventTime:event.eventTime,
        eventLocation: event.eventLocation,
        userCode: event.userCode,
      );
      EventsToDatetimeList.add(teacherevent);
    }
    Map<DateTime, List<TeacherEventsDateTime>> datetimeGroups =
    groupBy(EventsToDatetimeList, (TeacherEventsDateTime) {
      return TeacherEventsDateTime.eventDate;
    });
    setState(() {
      events.clear();
      events.addAll(datetimeGroups);
    });
  }

  void initState() {
    super.initState();
    eventToMap();
    selectedDay = DateTime.now();
    selectedEvents = [];
    events = {};
    controller = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;

    });
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
        title: Text(
          "Events",
          style: AppTextStyle.headerStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
              child: Container(
                child: _buildTableCalendarWithBuilders(),
                decoration: BoxDecoration(
                    color: ColorSet.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorSet.shadowcolour,
                        spreadRadius: 4,
                        blurRadius: 3,
                        offset: Offset(1, 3),
                      ),
                    ]),
              ),
            ),
            const SizedBox(height: 8.0),
            const SizedBox(height: 8.0),
            Expanded(child: _buildEventList()),
          ],
        ),
      ),
      //bottomNavigationBar: MyBottomBar(),
    );
  }
  Widget _buildTableCalendarWithBuilders() {
    print("from build calendar $events");
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
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Color.fromRGBO(18, 100, 97, 0.5),
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
      onDaySelected: (date, events, _) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
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
            ? Colors.brown[300]
            : controller.isToday(date)
            ? Colors.brown[300]
            : Colors.brown[300],
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
    return  selectedEvents.length==0?
    Padding(
      padding:const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        child: Container(
          child: Center(
            child: Text("No events today",style: AppTextStyle.headerStyle,),
          ),
        ),
      ),
    )
        :ListView(
            children: selectedEvents.map((event) {
              return Padding(padding:const EdgeInsets.only(right: 20, left: 20,bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorSet.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(15) ),),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10,top: 12),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  children: [
                                    Icon(Icons.event_available,color: Colors.green,size: 15),
                                    SizedBox(width: 2,),
                                    Text(
                                      'Event',
                                      style: TextStyle(color: Colors.green , fontSize: 15 , fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                  ],
                                )),
                            SizedBox(height: 2,),
                            Text(
                              ((DateFormat.yMd().format((event as TeacherEventsDateTime).eventDate))).toString().substring(0, 9),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: ColorSet.inactiveColor),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 7 , bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${(event as TeacherEventsDateTime).eventNameEN}',
                                  style: TextStyle(color: Colors.green ,fontSize: 12,fontWeight: FontWeight.bold ),
                                  maxLines: 3,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${(event as TeacherEventsDateTime).eventDescriptionEN}',
                                  style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 10 ),
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ),
                  ),
                ),
              ) ;
            }).toList()
        );
  }

}

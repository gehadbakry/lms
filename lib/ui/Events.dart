import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/NotifiCountAll.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/calender_info.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/calendar_dateTime.dart';
import 'package:lms_pro/models/calender_data.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import '../Chat/ChatButton.dart';
import '../Chat/customDrawer.dart';
import 'package:lms_pro/utils/myBottomBar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_style.dart';
import 'package:lms_pro/utils/EventsFunction.dart';

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
  List<CalenderDateTime> convertedToDatetimeList = [];
  Student student;
  var usercode;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //FUNCTION CONVERTS THE API RESPONCE TO A MAP TO BE ABLE TO SHOW IT IN THE CALENDAR
  eventsToMap() async {
    List<Calender> calendar = await CalendarInfo().getEventsCalendar(
        int.parse(Provider.of<APIService>(context, listen: false).code));
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
      } else if (calendarResponse.type == 2) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
          absenceDate: DateTime.parse(calendarResponse.absenceDate),
          absenceReasonAr: calendarResponse.absenceReasonAr,
          absenceReasonEn: calendarResponse.absenceReasonEn,
          absenceNote: calendarResponse.absenceNote,
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime);
      } else if (calendarResponse.type == 3) {
        CalenderDateTime calenderDateTime = CalenderDateTime(
          stageVaccDate: DateTime.parse(calendarResponse.stageVaccDate),
          vaccNote: calendarResponse.vaccNote,
          vaccNameAr: calendarResponse.vaccNameAr,
          vaccNameEn: calendarResponse.vaccNameEn,
          type: calendarResponse.type,
        );
        convertedToDatetimeList.add(calenderDateTime);
      } else if (calendarResponse.type == 4) {
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
      } else if (calendarResponse.type == 5) {
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
    student = ModalRoute.of(context).settings.arguments;
    setState(() {
      if (Provider.of<APIService>(context, listen: false).usertype == "2") {
        code = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
      } else if (Provider.of<APIService>(context, listen: false).usertype ==
          "3" ||
          Provider.of<APIService>(context, listen: false).usertype == "4") {
        code = (student.studentCode).toString();
        usercode = (student.userCode).toString();
      }
    });

    print("from build body $events");
    //CUSTOM APP BAR
    Widget myAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        "Events",
        style: AppTextStyle.headerStyle,
      ),
      actions: [
        Stack(
          children: [
            IconButton(
                icon: Icon(Icons.notifications),
                color: ColorSet.whiteColor,
                iconSize: 25,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Notifi(
                          userCode:  usercode.runtimeType == String
                              ? int.parse( usercode)
                              :  usercode,
                          code: code,
                        )),
                  );
                }),
            Positioned(
              right: 10,
              top: 10,
              child: FutureBuilder<AllCount>(
                  future: NotificationAllCount().getAllNotificationCount(
                      usercode.runtimeType == String
                          ? int.parse(usercode)
                          : usercode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.allNotification == '0'
                          ? Container(
                        height: 0,
                        width: 0,
                      )
                          : Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            snapshot.data.allNotification,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("error"));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ),

      ],
    );

    return Scaffold(
      floatingActionButton: ChatButton(userCode: usercode,code: code,),
      backgroundColor: ColorSet.primaryColor,
      appBar: myAppBar,
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
    )      :
    ListView(
      children: selectedEvents.map((event) {
        if ((event as CalenderDateTime).type == 1){
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
                              Icon(Icons.celebration,color: Colors.purple,size: 15),
                              SizedBox(width: 2,),
                              Text(
                                'Journey',
                                style: TextStyle(color: Colors.purple , fontSize: 15 , fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ],
                          )),
                      SizedBox(height: 2,),
                    Text(
                        ((DateFormat.yMd().format((event as CalenderDateTime).dateFrom))).toString().substring(0, 9),
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
                            '${(event as CalenderDateTime).journeyName}',
                            style: TextStyle(color: Colors.purple ,fontSize: 12,fontWeight: FontWeight.bold ),
                            maxLines: 3,
                        ),
                         ),
                        (event as CalenderDateTime).notes==null?Text(''):Text(
                          '${(event as CalenderDateTime).notes}',
                          style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                trailing:  Icon(Icons.arrow_forward_ios,color: Colors.purple,size: 20,),
                onTap: ()=> EventFunction().JourneyFunction(context,(event as CalenderDateTime).journeyName,
                    (event as CalenderDateTime).cost, (event as CalenderDateTime).dateFrom,
                    (event as CalenderDateTime).dateTo,
                    (event as CalenderDateTime).notes,
                    (event as CalenderDateTime).companionAllowed,
                    (event as CalenderDateTime).maxStudent,
                    (event as CalenderDateTime).finalDate,
                  (event as CalenderDateTime).maxCompanion,
                ),
              ),
            ),
          ),
          ) ;
        }
        else if((event as CalenderDateTime).type == 2){
          return Padding(padding:const EdgeInsets.only(right: 20, left: 20,bottom: 10),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Icon(Icons.account_circle_outlined,color: Colors.green,size: 17),
                                SizedBox(width: 2,),
                                Text(
                                  'Absence',
                                  style: TextStyle(color: Colors.green , fontSize: 15 , fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ],
                            )),
                        SizedBox(height: 2,),
                      Text(
                          ((DateFormat.yMd().format((event as CalenderDateTime).absenceDate))).toString().substring(0, 9),
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
                      padding: EdgeInsets.only(top: 15 , bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${(event as CalenderDateTime).absenceReasonEn}',
                              style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                              maxLines: 3,
                            ),
                          ),
                          (event as CalenderDateTime).absenceNote==null?Text(""):Text(
                            '${(event as CalenderDateTime).absenceNote}',
                            style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  trailing:  Icon(Icons.arrow_forward_ios,color: Colors.green,size: 20,),
                  onTap: ()=> EventFunction().AbsenceFunction(context,(event as CalenderDateTime).absenceDate,
                    (event as CalenderDateTime).absenceNote,
                    (event as CalenderDateTime).absenceReasonEn,
                    (event as CalenderDateTime).absenceReasonAr,
                  ),
                ),
              ),
            ),
          ) ;
        }
        else if((event as CalenderDateTime).type == 3){
          return Padding(padding:const EdgeInsets.only(right: 20, left: 20,bottom: 10),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.syringe,color: Colors.blue,size: 17),
                                SizedBox(width: 2,),
                                Text(
                                  'Vaccination',
                                  style: TextStyle(color:  Colors.blue , fontSize: 15 , fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ],
                            )),
                        SizedBox(height: 2,),
                        Text(
                          ((DateFormat.yMd().format((event as CalenderDateTime).stageVaccDate))).toString().substring(0, 10),
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
                      padding: EdgeInsets.only(top: 15 , bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${(event as CalenderDateTime).vaccNameEn}',
                              style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                              maxLines: 3,
                            ),
                          ),
                          (event as CalenderDateTime).vaccNote==null?Text(""):Text(
                            '${(event as CalenderDateTime).vaccNote}',
                            style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  trailing:  Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 20,),
                  onTap: ()=> EventFunction().VaccineFunction(context,(event as CalenderDateTime).stageVaccDate,
                    (event as CalenderDateTime).vaccNote,
                    (event as CalenderDateTime).vaccNameEn,
                    (event as CalenderDateTime).vaccNameAr,
                  ),
                ),
              ),
            ),
          ) ;
        }
        else if((event as CalenderDateTime).type == 4){
          return Padding(padding:const EdgeInsets.only(right: 20, left: 20,bottom: 10),
            child: Container(
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.calendarDay,color: Colors.brown,size: 12),
                              SizedBox(width: 2,),
                              Text(
                                'Event',
                                style: TextStyle(color:  Colors.brown , fontSize: 15 , fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ],
                          )),
                      SizedBox(height: 2,),
                      Text(
                        ((DateFormat.yMd().format((event as CalenderDateTime).eventDate))).toString().substring(0, 9),
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
                    padding: EdgeInsets.only(top: 15 , bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${(event as CalenderDateTime).eventNameEn}',
                            style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                            maxLines: 3,
                          ),
                        ),
                        (event as CalenderDateTime).eventDescEn==null?Text(""):Text(
                          '${(event as CalenderDateTime).eventNameEn}',
                          style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                trailing:  Icon(Icons.arrow_forward_ios,color: Colors.brown,size: 20,),
                onTap: ()=> EventFunction().EventsFunction(context,
                  (event as CalenderDateTime).eventDate,
                  (event as CalenderDateTime).eventNameEn,
                  (event as CalenderDateTime).eventNameAr,
                  (event as CalenderDateTime).eventDescEn,
                  (event as CalenderDateTime).eventDescAr,
                  (event as CalenderDateTime).eventCost,
                  (event as CalenderDateTime).eventTime,
                  (event as CalenderDateTime).eventLocation,
                ),
              ),
            ),
          ) ;
        }
        else if ((event as CalenderDateTime).type == 5) {
          return Padding(
              padding: const EdgeInsets.only(right: 20, left: 20,bottom: 10),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Icon(Icons.remove_circle_outlined,color: Colors.red,size: 15),
                                  SizedBox(width: 2,),
                                  Text(
                                    'Violation',
                                    style: TextStyle(color: Colors.red , fontSize: 15 , fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ],
                              )),
                          SizedBox(height: 2,),
                          Text(
                            ((DateFormat.yMd().format((event as CalenderDateTime).violationDate))).toString().substring(0, 9),
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
                        padding: EdgeInsets.only(top: 10 , bottom: 5),
                        child:
                       Column(
                         children: [
                           Text(
                              '${(event as CalenderDateTime).violationNameAr}',
                              style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12 ),
                              maxLines: 3,
                            ),
                           (event as CalenderDateTime).violationNote==null?Text(''):Text(
                             '${(event as CalenderDateTime).violationNote}',
                             style: TextStyle(color: ColorSet.inactiveColor ,fontSize: 12 ),
                             maxLines: 3,
                           ),
                         ],
                       ),
                      ),
                    ),
                    trailing:  Icon(Icons.arrow_forward_ios,color: Colors.red,size: 20,),
                    onTap: ()=> EventFunction().ViolationFunction(context,
                      (event as CalenderDateTime).violationDate,
                      (event as CalenderDateTime).violationNote,
                      (event as CalenderDateTime).violationNameAr,
                      (event as CalenderDateTime).violationNameEn,
                       ),
                    ),
                ),
                ),
              );
        }
      }).toList(),
    );
  }

}


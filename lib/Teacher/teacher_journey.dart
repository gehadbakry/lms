import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/models/calender_data.dart';
import 'package:lms_pro/teacher_api/getTeacherJourneys.dart';
import 'package:lms_pro/teacher_models/teacher_journey_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app_style.dart';

class TeacherJourneys extends StatefulWidget {
  final stageSubjectCode;

  const TeacherJourneys({Key key, this.stageSubjectCode}) : super(key: key);

  @override
  _TeacherJourneysState createState() => _TeacherJourneysState();
}

class _TeacherJourneysState extends State<TeacherJourneys> with TickerProviderStateMixin{
  int code;
  int SchoolYear;
  int subjestStageCode;
  List<TeacherJourneyDateTime> JourneysToDatetimeList = [];
  static Map<DateTime, List> events;
  CalendarController controller;
  Calender calender;
  List selectedEvents;
  AnimationController _animationController;
  DateTime selectedDay;

  journyToMap() async {
    List<TeacherJourney> Journyes = await TeacherJourneyInfo()
        .getTeacherJourneyInfo(
            int.parse(Provider.of<APIService>(context, listen: false).code));
    for (TeacherJourney jour in Journyes) {
      TeacherJourneyDateTime teacherjourny = TeacherJourneyDateTime(
        numberOfCompanions: jour.numberOfCompanions,
        journeyNameEn: jour.journeyNameEn,
        journeyNameAr: jour.journeyNameAr,
        journeyName: jour.journeyName,
        journeyCode: jour.journeyCode,
        companionAllowed: jour.companionAllowed,
        dateFrom: DateTime.parse(jour.dateFrom),
        dateTo: DateTime.parse(jour.dateTo),
      );
      JourneysToDatetimeList.add(teacherjourny);
    }
    Map<DateTime, List<TeacherJourneyDateTime>> datetimeGroups =
        groupBy(JourneysToDatetimeList, (TeacherJourneyDateTime) {
      return TeacherJourneyDateTime.dateFrom;
    });
    setState(() {
      events.clear();
      events.addAll(datetimeGroups);
    });
  }

  @override
  void initState() {
    super.initState();
    journyToMap();
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
      subjestStageCode = widget.stageSubjectCode;
    });
    return Scaffold(
        backgroundColor: ColorSet.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorSet.primaryColor,
          elevation: 0.0,
          title: Text(
            "Journeys",
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
    ),);
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
    return selectedEvents.length == 0
        ? Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Container(
              child: Container(
                child: Center(
                  child: Text(
                    "No events today",
                    style: AppTextStyle.headerStyle,
                  ),
                ),
              ),
            ),
          )
        :  Container(
      decoration: BoxDecoration(
        color: ColorSet.whiteColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15) ),),
      child: ListView(
        children: selectedEvents.map((event) {
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
                            ((DateFormat.yMd().format((event as TeacherJourneyDateTime).dateFrom))).toString().substring(0, 9),
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
                                '${(event as TeacherJourneyDateTime).journeyName}',
                                style: TextStyle(color: Colors.purple ,fontSize: 12,fontWeight: FontWeight.bold ),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   // trailing:  Icon(Icons.arrow_forward_ios,color: Colors.purple,size: 20,),
                    // onTap: () => JourneyFunction(context,
                    //     (event as TeacherJourneyDateTime).journeyName,
                    //     (event as TeacherJourneyDateTime).journeyNameAr,
                    //     (event as TeacherJourneyDateTime).journeyNameEn,
                    //     (event as TeacherJourneyDateTime).dateFrom,
                    //     (event as TeacherJourneyDateTime).dateTo,
                    //     (event as TeacherJourneyDateTime).companionAllowed,
                    //     (event as TeacherJourneyDateTime).numberOfCompanions)
                    ),
                  ),
                ),
            ) ;
        }).toList(),
      ),
    );
  }
  // JourneyFunction(var context,var Jname,var JnameAR,var JnameEN ,var JdateFrom,var JdateTo ,var allowedComp ,var maxComp) {
  //   var alert = AlertDialog(
  //     title: Column(
  //       children: [
  //         ListTile(
  //           title: Text(Jname,style: TextStyle(color: Colors.purple ,fontSize: 15,fontWeight:FontWeight.bold),) ,
  //           trailing: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('From: ${DateFormat.yMd().format(JdateFrom).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold) ,),
  //               Text('To: ${DateFormat.yMd().format(JdateTo).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold)),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10),
  //           child: Divider(height: 1,thickness: 2,),
  //         ),
  //       ],
  //     ),
  //     content: Container(
  //       height: 170,
  //       child: Padding(
  //         padding: const EdgeInsets.only(right: 20),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(Icons.person , color: Colors.purple ,),
  //                 SizedBox(width: 3,),
  //
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Icon(Icons.account_balance_wallet , color: Colors.purple,),
  //                 SizedBox(width: 3,),
  //
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Icon(Icons.group_add , color: Colors.purple,),
  //                 SizedBox(width: 3,),
  //                 Row(
  //                   children: [
  //                     Text("Company Allowed :",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold)),
  //                     allowedComp==true?Icon(Icons.check,color: ColorSet.inactiveColor,size: 20,):
  //                     Icon(Icons.cancel_outlined,color: ColorSet.inactiveColor,size: 20)
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             allowedComp==true?Row(
  //               children: [
  //                 Icon(Icons.group , color: Colors.purple,),
  //                 SizedBox(width: 3,),
  //                 RichText(text: TextSpan(text: "Max NO of companions:",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
  //                   children:<TextSpan>[TextSpan(text: maxComp.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
  //                 )),
  //               ],
  //             ):Text('')
  //           ],
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       FlatButton(
  //         child: Text(
  //           "Okay",
  //           style: TextStyle(color: Colors.purple),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       )
  //     ],
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(24.0),
  //       ),
  //     ),
  //   );
  //   showDialog(context: context, builder: (context) => alert);
  // }

}

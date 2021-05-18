import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/calender_info.dart';
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
  Map<DateTime, List> events;
  AnimationController _animationController;
  DateTime current = DateTime.now();


  @override
  void initState() {
    super.initState();
    controller = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var newheight = (MediaQuery.of(context).size.height - AppBar().preferredSize.height-MediaQuery.of(context).padding.top );
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
    });
    print(CalendarInfo().events);

    //CUSTOM APP BAR
    Widget myAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BNV()),
            );
          }) ,
      centerTitle: true,
      title: Text("Events" ,style: AppTextStyle.headerStyle,),
      actions: [
        IconButton(icon: Icon(Icons.notifications),
            color: ColorSet.whiteColor,
            iconSize: 25,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifi()),
              );
            })
      ],
    ) ;

    return Scaffold(
      floatingActionButton: ChatButton(),
      backgroundColor: ColorSet.primaryColor,
      appBar: myAppBar,
      body:ListView(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width*0.93,
              child: TableCalendar(calendarController: controller,
                headerStyle: HeaderStyle(formatButtonVisible: false),
                calendarStyle: CalendarStyle(
                  weekdayStyle: TextStyle(color: ColorSet.primaryColor),
                  weekendStyle: TextStyle(color: ColorSet.primaryColor),
                  outsideWeekendStyle: TextStyle(color: ColorSet.primaryColor),
                  holidayStyle: TextStyle(color: ColorSet.primaryColor),
                  outsideHolidayStyle: TextStyle(color: ColorSet.primaryColor),
                ),
                events: CalendarInfo().events,
              ),
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
          ),
          SizedBox(height: 10,),
          //SHOW EVENTS CONTAINER
        ],
      ),
    );
  }
//   //FUNCTION THAT CONVERT RESPONCE TO A MAP

}


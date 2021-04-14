import 'package:flutter/material.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_style.dart';
class Events extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const Events(
      {Key key,
        this.menuScreenContext,
        this.onScreenHideButtonPressed,
        this.hideStatus = false})
      : super(key: key);
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  CalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    var newheight = (MediaQuery.of(context).size.height - AppBar().preferredSize.height-MediaQuery.of(context).padding.top );


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
      //SETTING THE CALANDAR AND CALENDAR STYLE
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
          Container(
            width: double.infinity,
            child: Column(
              children: [
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),
                ListTile(title: Text("hello",style: TextStyle(fontSize: 55),),),

              ],
            ),
            decoration: BoxDecoration(
                color: ColorSet.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            ),
          ),
        ],
      ),
    );

  }
//   //FUNCTION THT CHANGES THE EVENTS MAP TO STRING
//    Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
//      Map<String, dynamic> newMap = {};
//      map.forEach((key, value) {
//        newMap[key.toString()] = map[key];
//      });
//      return newMap;
//    }
// //FUNCTION CHANGES STRING INTO MAP
//    Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
//      Map<DateTime, dynamic> newMap = {};
//      map.forEach((key, value) {
//        newMap[DateTime.parse(key)] = map[key];
//      });
//      return newMap;
//    }
}


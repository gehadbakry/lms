import 'package:flutter/material.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_style.dart';
class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

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
            Navigator.pop(
              context,
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
      appBar: myAppBar,
      //SETTING THE CALANDAR
      body:null,
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


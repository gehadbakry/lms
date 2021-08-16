import 'package:flutter/material.dart';
import 'package:lms_pro/Teacher/teacher_student_behaviour.dart';
import 'package:lms_pro/Teacher/teacher_students_list.dart';

import '../app_style.dart';
class AttendBehavTabs extends StatefulWidget {
  final int tableCode;
  final String stageName;
  final String className;

  const AttendBehavTabs({Key key, this.tableCode, this.stageName, this.className}) : super(key: key);
  @override
  _AttendBehavTabsState createState() => _AttendBehavTabsState();
}

class _AttendBehavTabsState extends State<AttendBehavTabs> {
  @override
  Widget build(BuildContext context) {
    Widget bottomAppBar = PreferredSize(
        preferredSize:  Size.fromHeight(35),
        child: AppBar(
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          backgroundColor: ColorSet.whiteColor,
          elevation: 0.0,
          bottom: TabBar(
            tabs:[
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Attendence",style:TextStyle(color: ColorSet.primaryColor,),)),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Behaviour",style:TextStyle(color: ColorSet.primaryColor,),)),
            ],
            //indicatorWeight: 0.005,
            indicatorColor: ColorSet.whiteColor,
            labelPadding: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.015,),

            unselectedLabelStyle: TextStyle(color: ColorSet.inactiveColor ,fontWeight: FontWeight.normal) ,
          ),
        ));
    return DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorSet.primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${widget.stageName} '),
                Text('${widget.className}'),
              ],
            ),
          ),
          body:  Scaffold(
            backgroundColor: ColorSet.whiteColor,
            appBar: bottomAppBar,
            body: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: ClassStudentsList(tableCode: widget.tableCode,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: ClassStudentsBehaviour(tableCode: widget.tableCode,),
                )
              ],

            ),
          ),
        ));
  }
}

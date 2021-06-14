import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/NotifiCountAll.dart';
import 'package:lms_pro/api_services/all_days_info.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/all_days_scheduel.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import '../Chat/ChatButton.dart';
import 'package:lms_pro/utils/buildScheduelPage.dart';
import '../Chat/customDrawer.dart';
import 'package:lms_pro/utils/myBottomBar.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_style.dart';
import 'NotifiPage.dart';

class Scheduel extends StatefulWidget {
  @override
  _ScheduelState createState() => _ScheduelState();
}

class _ScheduelState extends State<Scheduel> {
  var Scode;
  var yearCode;
  Student student;
  var usercode;

  @override
  Widget build(BuildContext context) {
    student = ModalRoute.of(context).settings.arguments;
    setState(() {
      if (Provider.of<APIService>(context, listen: false).usertype == "2") {
        Scode = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
        yearCode = Provider.of<APIService>(context, listen: false).schoolYear;
      } else if (Provider.of<APIService>(context, listen: false).usertype ==
              "3" ||
          Provider.of<APIService>(context, listen: false).usertype == "4") {
        Scode = (student.studentCode).toString();
        usercode = student.userCode;
        yearCode = Provider.of<APIService>(context, listen: false).schoolYear;
      }
    });
    //AllDaysScheduelInfo().getAllDays(int.parse(Scode), yearCode);
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/BNV');
          }),
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
                          code: Scode,
                        )),
                  );
                }),
            Positioned(
              right: 10,
              top: 10,
              child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: FutureBuilder<AllCount>(
                    future: NotificationAllCount().getAllNotificationCount(
                        usercode.runtimeType == String
                            ? int.parse( usercode)
                            :  usercode),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            snapshot.data.allNotification,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('error'),
                        );
                      }
                      return FittedBox(
                        fit: BoxFit.fill,
                        child: CircularProgressIndicator(),
                      );
                    },
                  )),
            )
          ],
        ),
      ],
      centerTitle: true,
      title: Text("Scheduel", style: AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
    );
    Widget bottomAppBar =  PreferredSize(
      preferredSize: Size.fromHeight(55.0),
      child: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        elevation: 0.0,
        backgroundColor: ColorSet.whiteColor,
        automaticallyImplyLeading: false,
        bottom:TabBar(
          tabs: [
            // Text("Sun",maxLines: 1,softWrap: true,),
            // Text("Mon",maxLines: 1,softWrap: true,),
            // Text("Tues",maxLines: 1,softWrap: true,),
            // Text("Wedn",maxLines: 1,softWrap: true,),
            // Text("Thur",maxLines: 1,softWrap: true,),
            DaysButton("Sun",context),
            DaysButton("Mon",context),
            DaysButton("Tues",context),
            DaysButton("Wed",context),
            DaysButton("Thur",context),
          ],
          labelColor: ColorSet.primaryColor,
          unselectedLabelColor:Colors.grey  ,
          indicatorWeight: 0.005,

        ) ,
      ), );
    //Allowed height to work with
    var newheight = (MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    String day;
    return Scaffold(
      appBar: MyAppBar,
      body: DefaultTabController(
            length: 5,
            child: FutureBuilder<List<AllDaysScheduel>>(
              future: AllDaysScheduelInfo().getAllDays(int.parse(Scode), yearCode),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return snapshot.data.length==0?
                  Scaffold(appBar: bottomAppBar,
                    backgroundColor: ColorSet.whiteColor,
                    body: Center(
                      child:Text("No scheduel was found",style: AppTextStyle.headerStyle2,),
                    ),
                  )
                      : Scaffold(
                    appBar: bottomAppBar,
                    backgroundColor: ColorSet.primaryColor,
                    body: TabBarView(
                      children: [
                        ////GRABI TDI KOL PAGE EL CODE BTA3 EL YOUM
                        ScheduelPage(dayCode: snapshot.data[0].dayCode,),
                        ScheduelPage(dayCode: snapshot.data[1].dayCode,),
                        ScheduelPage(dayCode: snapshot.data[2].dayCode,),
                        ScheduelPage(dayCode: snapshot.data[3].dayCode,),
                        ScheduelPage(dayCode: snapshot.data[4].dayCode,),
                      ],
                    ),
                  );
                }
                else if (snapshot.hasError){
                  return Center(child: Text("error"));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),


          ),
      floatingActionButton: ChatButton(userCode: usercode,code: Scode,),
    );
    //   Scaffold(
    //   appBar: MyAppBar,
    //   backgroundColor: ColorSet.primaryColor,
    //   body: DefaultTabController(
    //     length: 5,
    //     child: FutureBuilder<List<AllDaysScheduel>>(
    //       future: AllDaysScheduelInfo().getAllDays(int.parse(Scode), yearCode),
    //       builder: (context,snapshot){
    //         if(snapshot.hasData){
    //           return snapshot.data.length==0?
    //           Scaffold(appBar: bottomAppBar,
    //             backgroundColor: ColorSet.whiteColor,
    //             body: Center(
    //               child:Text("No scheduel was found",style: AppTextStyle.headerStyle2,),
    //             ),
    //           )
    //               : Scaffold(
    //             appBar: bottomAppBar,
    //             backgroundColor: ColorSet.primaryColor,
    //             body: TabBarView(
    //               children: [
    //                 ////GRABI TDI KOL PAGE EL CODE BTA3 EL YOUM
    //                 //Sunday(dayCode: snapshot.data[0].dayCode,),
    //                 ScheduelPage(dayCode: snapshot.data[0].dayCode,),
    //                 ScheduelPage(dayCode: snapshot.data[1].dayCode,),
    //                 ScheduelPage(dayCode: snapshot.data[2].dayCode,),
    //                 ScheduelPage(dayCode: snapshot.data[3].dayCode,),
    //                 ScheduelPage(dayCode: snapshot.data[4].dayCode,),
    //               ],
    //             ),
    //           );
    //         }
    //         else if (snapshot.hasError){
    //           return Center(child: Text("error"));
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       },
    //     ),
    //
    //
    //   ),
    //   // body:
    //   floatingActionButton: ChatButton(),
    //
    // );
  }

//DAYS' NAMES CONTAINERS
  Container DaysButton(String day, BuildContext ctx) {
    return Container(
      height: 35,
      width: (MediaQuery.of(ctx).size.width -
              MediaQuery.of(ctx).padding.right -
              MediaQuery.of(ctx).padding.left) *
          0.3,
      decoration: BoxDecoration(
        color: ColorSet.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: ColorSet.shadowcolour,
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Center(
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "$day",
                maxLines: 1,
                softWrap: true,
              ))),
    );
  }
}

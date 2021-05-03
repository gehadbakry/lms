import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/all_days_info.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/models/all_days_scheduel.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/buildScheduelPage.dart';
import 'package:lms_pro/utils/customDrawer.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';


import '../app_style.dart';
import 'NotifiPage.dart';

class Scheduel extends StatefulWidget {
  @override
  _ScheduelState createState() => _ScheduelState();
}

class _ScheduelState extends State<Scheduel> {
  @override
  Widget build(BuildContext context) {
    var Scode;
    var yearCode;
    setState(() {
      Scode = Provider.of<APIService>(context, listen: false).code;
      yearCode =Provider.of<APIService>(context, listen: false).schoolYear;
    });
   //AllDaysScheduelInfo().getAllDays(int.parse(Scode), yearCode);
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BNV()),
                );
          }) ,
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
      centerTitle: true,
      title: Text("Scheduel", style:AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
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
           DaysButton("Sun",context),
           DaysButton("Mon",context),
           DaysButton("Tues",context),
           DaysButton("Wed",context),
           DaysButton("Thur",context),
         ],
         unselectedLabelStyle: TextStyle(color: Colors.grey ,fontWeight: FontWeight.normal) ,
         indicatorWeight: 0.005,

       ) ,
     ), );
    //Allowed height to work with
    var newheight = (MediaQuery.of(context).size.height - AppBar().preferredSize.height-MediaQuery.of(context).padding.top );
    String day;
    return Scaffold(
      appBar: MyAppBar,
      backgroundColor: ColorSet.primaryColor,
      body: DefaultTabController(
        length: 5,
          child: FutureBuilder<List<AllDaysScheduel>>(
            future: AllDaysScheduelInfo().getAllDays(int.parse(Scode), yearCode),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return  Scaffold(
                  appBar: bottomAppBar,
                  backgroundColor: ColorSet.primaryColor,
                  body: TabBarView(
                    children: [
                      ////GRABI TDI KOL PAGE EL CODE BTA3 EL YOUM
                      //Sunday(dayCode: snapshot.data[0].dayCode,),
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
      // body:
      floatingActionButton: ChatButton(),
    );
  }
//DAYS' NAMES CONTAINERS
  Container DaysButton(String day ,  BuildContext ctx) {
    return Container(
      height:35 ,
      width: (MediaQuery.of(ctx).size.width -MediaQuery.of(ctx).padding.right-MediaQuery.of(ctx).padding.left)*0.3,
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
      child: Center(child: FittedBox(
        fit: BoxFit.fitWidth,
          child: Text("$day",style: AppTextStyle.headerStyle2,maxLines: 1,softWrap: true,))),
    );
  }

}

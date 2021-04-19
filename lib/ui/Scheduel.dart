import 'package:flutter/material.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/buildScheduelPage.dart';
import 'package:timeline_tile/timeline_tile.dart';


import '../app_style.dart';
import 'NotifiPage.dart';

class Scheduel extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const Scheduel(
      {Key key,
        this.menuScreenContext,
        this.onScreenHideButtonPressed,
        this.hideStatus = false})
      : super(key: key);
  @override
  _ScheduelState createState() => _ScheduelState();
}

class _ScheduelState extends State<Scheduel> {
  @override
  Widget build(BuildContext context) {
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
   Widget bottomAppBar = PreferredSize(
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
////////////////////////GARABI EL MAP/////////////////////////////////////////////
    return Scaffold(
      appBar: MyAppBar,
      backgroundColor: ColorSet.primaryColor,
      body: DefaultTabController(
        length: 5,
          child: Scaffold(
            appBar: bottomAppBar,
              backgroundColor: ColorSet.primaryColor,
            body: TabBarView(
              children: [
                ScheduelPage(),
                ScheduelPage(),
                ScheduelPage(),
                ScheduelPage(),
                ScheduelPage(),
              ],
            ),
          )
      ),
      // body:
      floatingActionButton: ChatButton(),
    );
  }
//DAYS' NAMES CONTAINERS
  Container DaysButton(String day ,  BuildContext ctx) {
    return Container(
      height:35 ,
      width: (MediaQuery.of(ctx).size.width -MediaQuery.of(ctx).padding.right-MediaQuery.of(ctx).padding.left)*0.30,
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
      child: Center(child: Text("$day",style: AppTextStyle.headerStyle2,maxLines: 1,softWrap: true,)),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
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
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
            Navigator.pop(
              context,);
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
    Widget TimeContainer = Container(
      height: 120,
      child:  Padding(
        padding: const EdgeInsets.only(left: 25,top: 30),
        child: TimelineTile(

          indicatorStyle: IndicatorStyle(
            color: ColorSet.primaryColor,
            indicatorXY: 0.4,
            drawGap: true,
          ),
          endChild: ListTile(
            title: Text("English" , style: AppTextStyle.headerStyle2,),
            subtitle: Text("Teacher Name\nDetails" , style: AppTextStyle.subtextgrey,),
            trailing: Text("8:00 Am : 8:30 Am",style: AppTextStyle.subText,),
          ),
          isFirst: true,
        ),
      ),
    );

    //Allowed height to work with
    var newheight = (MediaQuery.of(context).size.height - AppBar().preferredSize.height-MediaQuery.of(context).padding.top );
    String day;
////////////////////////GARABI EL MAP/////////////////////////////////////////////
    return Scaffold(
      appBar: MyAppBar,
      body: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DaysButton("Sun"),
              SizedBox(width: 10,),
              DaysButton("Mon"),
              SizedBox(width: 10,),
              DaysButton("Tues"),
              SizedBox(width: 10,),
              DaysButton("Wed"),
              SizedBox(width: 10,),
              DaysButton("Thur"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 30),
            child: TimelineTile(

              indicatorStyle: IndicatorStyle(
                color: ColorSet.primaryColor,
                indicatorXY: 0.4,
                drawGap: true,
              ),
              endChild: ListTile(
                title: Text("English" , style: AppTextStyle.headerStyle2,),
                subtitle: Text("Teacher Name\nDetails" , style: AppTextStyle.subtextgrey,),
                trailing: Text("8:00 Am : 8:30 Am",style: AppTextStyle.subText,),
              ),
              isFirst: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: TimelineTile(
              indicatorStyle: IndicatorStyle(
                color: ColorSet.primaryColor,
              ),
              endChild: ListTile(
                title: Text("English" , style: AppTextStyle.headerStyle2,),
                subtitle: Text("Teacher Name\nDetails" , style: AppTextStyle.subtextgrey,),
                trailing: Text("8:00 Am : 8:30 Am",style: AppTextStyle.subText,),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ChatButton(),
    );
  }
//DAYS' NAMES CONTAINERS
  GestureDetector DaysButton(String day) {
    return GestureDetector(
              child: Container(
                height:35 ,
                width: 55,
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
                child: Center(child: Text("$day",style: AppTextStyle.headerStyle2,)),
              ),
            );
  }

}

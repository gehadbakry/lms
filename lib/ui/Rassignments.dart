import 'package:flutter/material.dart';
import 'package:lms_pro/utils/ChatButton.dart';

import '../app_style.dart';
import 'NotifiPage.dart';
class RecentAssignment extends StatefulWidget {
  @override
  _RecentAssignmentState createState() => _RecentAssignmentState();
}

class _RecentAssignmentState extends State<RecentAssignment> {
  @override
  Widget build(BuildContext context) {

    Widget MyAppBar = AppBar (
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
            Navigator.pop(
              context,);
          }) ,
      centerTitle: true,
      title: Text("Recent Assignments", style:AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      ),
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
    );
    return Scaffold(
      appBar: MyAppBar,
      body:ListView(
        children: [
          IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(child: Text("Yesterday" ,style: AppTextStyle.textstyle15,),
                      onTap:(){} ,),
                    SizedBox(width: 15,),
                    VerticalDivider(color: Colors.grey,width: 1,thickness: 1,endIndent: 0.5,),
                    SizedBox(width: 15,),
                    InkWell(child: Text("Today" ,style: AppTextStyle.textstyle15,),
                        onTap:(){}),
                    SizedBox(width: 15,),
                    VerticalDivider(color: Colors.grey,width: 1,thickness: 1,endIndent: 0.5,),
                    SizedBox(width: 15,),
                    InkWell(child: Text("Tomorrow" ,style: AppTextStyle.textstyle15,),
                        onTap:(){}),
                  ],
                ),
              )
          ),
          SizedBox(height: 25,),
          Container(
            height: 200,
            child:Card(
              color: ColorSet.whiteColor,
              elevation: 0.9,
              shadowColor: ColorSet.shadowcolour,
            ),
          ),
        ],
      ),
      floatingActionButton: ChatButton(),
    );
  }
}

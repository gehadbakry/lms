import 'package:flutter/material.dart';
import 'package:lms_pro/utils/ChatButton.dart';

import '../app_style.dart';
import 'NotifiPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lms_pro/models/Rassign.dart';
class RecentAssignment extends StatefulWidget {
  @override
  _RecentAssignmentState createState() => _RecentAssignmentState();
}

class _RecentAssignmentState extends State<RecentAssignment> {

  Future<Assignment> GAssign;
  //FETCHIING YOUR DATA
  Future<Assignment> getAssignment() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/comments/1');
    http.Response MyAssign = await http.get(url);
    if (MyAssign.statusCode == 200) {
    // print(MyAssign.body);
      return Assignment.fromJson(json.decode(MyAssign.body));
    } else {
      throw Exception("can't get data");
    }
  }
  void initState() {
    GAssign = getAssignment();
    super.initState();
  }

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
                    InkWell(child: Text("Yesterday" ,style: AppTextStyle.subtextgrey,),
                      highlightColor: ColorSet.primaryColor,
                      onTap:(){} ,),
                    SizedBox(width: 15,),
                    VerticalDivider(color: Colors.grey,width: 1,thickness: 1,endIndent: 0.5,),
                    SizedBox(width: 15,),
                    InkWell(child: Text("Today" ,style: AppTextStyle.subtextgrey,),
                        highlightColor: ColorSet.primaryColor,
                        onTap:(){}),
                    SizedBox(width: 15,),
                    VerticalDivider(color: Colors.grey,width: 1,thickness: 1,endIndent: 0.5,),
                    SizedBox(width: 15,),
                    InkWell(child: Text("Tomorrow" ,style: AppTextStyle.subtextgrey,),
                        highlightColor: ColorSet.primaryColor,
                        onTap:(){
                        }),
                  ],
                ),
              )
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 15 , right: 15 , bottom: 10),
            child: Card(
              shadowColor: ColorSet.shadowcolour,
              elevation: 9.0,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: ColorSet.borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Assignment Name" , style: AppTextStyle.textstyle20,),
                        SizedBox(width: 40,),
                        Text("10/10/10",style: AppTextStyle.subText,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Type" , style: AppTextStyle.subText,),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Subject Name ",style: AppTextStyle.subtextgrey,),
                        SizedBox(width: 100,),
                        Text("Result: 10",style: AppTextStyle.headerStyle2,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ChatButton(),
    );
  }
}

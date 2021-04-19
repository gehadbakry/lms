import 'package:flutter/material.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/buildPage.dart';

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
    Widget bottomAppBar = PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: AppBar(
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      backgroundColor: ColorSet.whiteColor,
      elevation: 0.0,
      bottom: TabBar(
        tabs: [
          Text("Yesterday",style:TextStyle(color: ColorSet.primaryColor,fontSize: 16)),
          Text("Today",style:TextStyle(color: ColorSet.primaryColor,fontSize: 16)),
          Text("Tomorrow",style:TextStyle(color: ColorSet.primaryColor,fontSize: 16)),
        ],
        indicatorWeight: 0.005,
        unselectedLabelStyle: TextStyle(color: Colors.grey ,fontWeight: FontWeight.normal) ,
      ) ,
    ),) ;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorSet.primaryColor,
        appBar: MyAppBar,
        body: Scaffold(
          backgroundColor: ColorSet.primaryColor,
          appBar: bottomAppBar,
          body: TabBarView(
            children: [
              buildPage(),
              buildPage(),
              buildPage(),
            ],
          ),
        ),
        floatingActionButton: ChatButton(),
      ),
    );
  }
}

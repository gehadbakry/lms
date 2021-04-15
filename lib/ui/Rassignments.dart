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
      bottom: TabBar(
        tabs: [
          Tab(text: "Yesterday",),
          Tab(text: "Today",),
          Tab(text: "Tomorrow",),
        ],
        indicatorWeight: 0.005,
      ) ,
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MyAppBar,
        body: TabBarView(
          children: [
            buildPage(),
            buildPage(),
            buildPage(),
          ],
        ),
        floatingActionButton: ChatButton(),
      ),
    );
  }
}

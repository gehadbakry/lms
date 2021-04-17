import 'package:flutter/material.dart';
import 'package:lms_pro/testpage.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/buildMaterialPage.dart';
import 'package:lms_pro/utils/buildQuizPage.dart';
import 'package:lms_pro/utils/buildSubjectDetails.dart';
import 'package:lms_pro/utils/subjectAssignDetails.dart';

import '../app_style.dart';
import 'NotifiPage.dart';

class SubjectDetails extends StatefulWidget {
  @override
  _SubjectDetailsState createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  @override
  Widget build(BuildContext context) {

    //CUSTOM APP BAR
    Widget myAppBar = PreferredSize(
      preferredSize: Size.fromHeight(105),
      child: AppBar(
        bottom: TabBar(
          tabs:[
            Tab(text: "Material",),
            Tab(text: "Assignments",),
            Tab(text: "Quiz",),
            Tab(text: "Online Exam",),
          ],
          indicatorWeight: 0.005,
          labelPadding: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.015
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 17),
          child: Container(
            //Row has avatar as leading and the card as trailing
            child: Row(
              children: [
                //Student's avatar
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/teacher.png'),
                  radius: 22.0,
                ),
                //Container that contains the identifiction card
                SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Subject Name" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 13)),
                        Text("Teacher's Name" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 16,fontWeight: FontWeight.w700),),
                      ],
                    ),
                  ),
                ),
              ],
            ),),
        ),
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
        leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
            iconSize: 25,
            onPressed: (){
              Navigator.pop(
                context,
              );
            }) ,
        actions: [
          IconButton(icon: Icon(Icons.search),
              color: ColorSet.whiteColor,
             // iconSize: 25,
              onPressed: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Notifi()),
                // );
              }),
          IconButton(icon: Icon(Icons.notifications),
              color: ColorSet.whiteColor,
             // iconSize: 25,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifi()),
                );
              }),
        ],
      ),
    ) ;


    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorSet.primaryColor,
        appBar: myAppBar,
        body: TabBarView(
          children: [
            BuildSubjectDetails(BuildMaterialPage()),
            BuildSubjectDetails(AssignmentDetails()),
            BuildSubjectDetails(QuizPageDetails()),
            BuildSubjectDetails(Test()),
          ],

        ),
        floatingActionButton: ChatButton(),
      ),
    );
  }
}

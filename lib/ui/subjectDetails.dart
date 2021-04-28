import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/subjects_info.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:lms_pro/testpage.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/buildMaterialPage.dart';
import 'package:lms_pro/utils/buildQuizPage.dart';
import 'package:lms_pro/utils/buildSubjectDetails.dart';
import 'package:lms_pro/utils/subjectAssignDetails.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import 'NotifiPage.dart';

class SubjectDetails extends StatefulWidget {
  @override
  _SubjectDetailsState createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  LoginResponseModel logInInfo;
  LoginRequestModel loginRequestModel;
  Subject subject;
  var gSubjectInfo;
  var subjectcode;
  var code;

  @override
  void initState() {
    loginRequestModel = LoginRequestModel();
    logInInfo = LoginResponseModel();
    subject = Subject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context).settings.arguments;
    //CUSTOM APP BAR
    Widget myAppBar = PreferredSize(
      preferredSize: Size.fromHeight(75),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 13),
          child: Container(
            //Row has avatar as leading and the card as trailing
            child: Row(
              children: [
                //Student's avatar
                CircleAvatar(
                   backgroundImage:HttpStatus.internalServerError != 500?
                   NetworkImage('http://169.239.39.105/LMS_site_demo/Home/GetImg?path=F:/docs${subject.teacherImg}'):
                    AssetImage('assets/images/teacher.png'),
                  radius: 23.0,
                ),
                SizedBox(width: 8,),
                //Container that contains the identifiction card
                Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                            child: Text("${subject.teacherNameEn}" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 16,fontWeight: FontWeight.w700),maxLines: 1,)
                        ),
                        Text("${subject.subjectNameEn}" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 13)),
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

    Widget bottomAppBar = PreferredSize(
        preferredSize:  Size.fromHeight(45),
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
        tabs:[
          FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Material",style:TextStyle(color: ColorSet.primaryColor,),)),
          FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Assignments",style:TextStyle(color: ColorSet.primaryColor,),)),
          FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Quiz",style:TextStyle(color: ColorSet.primaryColor,),)),
          FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Online Exams",style:TextStyle(color: ColorSet.primaryColor),)),
         ],
        indicatorWeight: 0.005,
        labelPadding: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.015,
        ),
        unselectedLabelStyle: TextStyle(color: Colors.grey ,fontWeight: FontWeight.normal) ,
      ),
    ));
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
      subjectcode = subject.subjectCode;
    });

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: ColorSet.whiteColor,
          appBar: myAppBar,
          body: Scaffold(
            backgroundColor: ColorSet.primaryColor,
            appBar: bottomAppBar,
            body: TabBarView(
              children: [
                BuildSubjectDetails(BuildMaterialPage()),
                BuildSubjectDetails(AssignmentDetails()),
                BuildSubjectDetails(QuizPageDetails()),
                BuildSubjectDetails(QuizPageDetails()),
              ],

            ),
            floatingActionButton: ChatButton(),
          ),
        ),

    );
  }
}

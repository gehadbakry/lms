import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/subjects_info.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:lms_pro/testpage.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/buildMaterialPage.dart';
import 'package:lms_pro/utils/buildQuizPage.dart';
import 'package:lms_pro/utils/buildSubjectDetails.dart';
import 'package:lms_pro/utils/build_online_exam.dart';
import 'package:lms_pro/utils/subjectAssignDetails.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
  Student student;
  var gSubjectInfo;
  var subjectcode;
  var code;
  var usercode;
  var args;

  @override
  void initState() {
    loginRequestModel = LoginRequestModel();
    logInInfo = LoginResponseModel();
    subject = Subject();
    student = Student();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    // subject = ModalRoute.of(context).settings.arguments;
    // student = ModalRoute.of(context).settings.arguments;
    //CUSTOM APP BAR



    Widget bottomAppBar = PreferredSize(
        preferredSize:  Size.fromHeight(35),
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
      if (Provider.of<APIService>(context, listen: false).usertype == "2"){
        code = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
        subjectcode = args[0].subjectCode;
      }
      else if(Provider.of<APIService>(context, listen: false).usertype == "3" ||Provider.of<APIService>(context, listen: false).usertype == "4" ){
        code = (args[1].studentCode).toString();
        usercode = (args[1].userCode).toString();
        subjectcode = args[0].subjectCode;
      }
    }
    );
    Widget myAppBar =PreferredSize(child: AppBar(
      toolbarHeight: MediaQuery.of(context).size.height*0.2,
      automaticallyImplyLeading: false,
      // centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Container(
          //Row has avatar as leading and the card as trailing
          child: Row(
            children: [
              //Student's avatar
              CircleAvatar(
                backgroundImage:HttpStatus.internalServerError != 500?
                NetworkImage('http://169.239.39.105/LMS_site_demo/Home/GetImg?path=F:/docs${subject.teacherImg}'):
                AssetImage('assets/images/teacher.png'),
                radius: 25.0,
              ),
              Spacer(),
              //Container that contains the identifiction card
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("${args[0].teacherNameEn}" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 10,fontWeight: FontWeight.bold),maxLines: 2,)
                      ),
                      Text("${args[0].subjectNameEn}" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),),
      ),
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
            iconSize: 25,
            onPressed: (){
              Navigator.pop(
                context,
              );
            }),
      ) ,
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: IconButton(icon: Icon(Icons.search),
              color: ColorSet.whiteColor,
              // iconSize: 25,
              onPressed: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Notifi()),
                // );
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: IconButton(icon: Icon(Icons.notifications),
              color: ColorSet.whiteColor,
              // iconSize: 25,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifi(userCode: usercode,)),
                );
              }),
        ),
      ],
    ), preferredSize: Size.fromHeight(122));
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: myAppBar,
          body: Scaffold(
            backgroundColor: ColorSet.primaryColor,
            appBar: bottomAppBar,
            body: TabBarView(
              children: [
                BuildSubjectDetails(BuildMaterialPage()),
                BuildSubjectDetails(AssignmentDetails()),
                BuildSubjectDetails(QuizPageDetails()),
                BuildSubjectDetails(OnlineExam()),
              ],

            ),
            floatingActionButton: ChatButton(),
          ),
        ),

    );
  }
}
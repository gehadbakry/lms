import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/NotifiCountAll.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/subjects_info.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:lms_pro/testpage.dart';
import '../Chat/ChatButton.dart';
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
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
              Navigator.pop(context);
            // else if(usertype=='4'|| usertype=='3'){
            //   Navigator.popAndPushNamed(
            //     context,'/choose');
            // }
          }),
      actions: [
        Stack(
          children: [
            IconButton(
                icon: Icon(Icons.notifications),
                color: ColorSet.whiteColor,
                iconSize: 25,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Notifi(
                          userCode:  usercode.runtimeType == String
                              ? int.parse( usercode)
                              :  usercode,
                          code: code,
                        )),
                  );
                }),
            Positioned(
              right: 10,
              top: 10,
              child: FutureBuilder<AllCount>(
                  future: NotificationAllCount().getAllNotificationCount(
                      usercode.runtimeType == String
                          ? int.parse(usercode)
                          : usercode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.allNotification == '0'
                          ? Container(
                        height: 0,
                        width: 0,
                      )
                          : Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            snapshot.data.allNotification,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("error"));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ),
      ],
    );

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorSet.primaryColor,
          appBar: MyAppBar,
          body: Column(
            children: [
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 15),
            child: Container(
              color: ColorSet.primaryColor,
              //Row has avatar as leading and the card as trailing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Student's avatar
                  CircleAvatar(
                    backgroundImage:HttpStatus.internalServerError != 500?
                    NetworkImage('http://169.239.39.105/LMS_site_demo/Home/GetImg?path=F:/docs${subject.teacherImg}'):
                    AssetImage('assets/images/teacher.png'),
                    radius: 27.0,
                  ),
                  //Container that contains the identifiction card
                  SizedBox(width: 6,),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("${args[0].teacherNameEn}" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 14,fontWeight: FontWeight.bold),maxLines: 2,)
                          ),
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("${args[0].subjectNameEn}" , style: TextStyle(color: ColorSet.whiteColor,fontSize: 13))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
              Expanded(
                child: Scaffold(
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
                  floatingActionButton: ChatButton(userCode: usercode,code: code,),
                ),
              ),
            ],
          ),
        ),

    );
  }
}

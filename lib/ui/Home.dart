import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:lms_pro/ui/Rassignments.dart';
import 'package:lms_pro/ui/SubjectPage.dart';
import 'package:lms_pro/ui/choose_student.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoginResponseModel logInInfo;
  var usercode;
  var usertype;
  var code;

  @override
  @override
  Widget build(BuildContext context) {
    logInInfo = ModalRoute.of(context).settings.arguments;
    usercode = (logInInfo.userCode);
    usertype = (logInInfo.userType);
    code = (logInInfo.code);
    //Coustume mde app bar
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.whiteColor,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.primaryColor,
          iconSize: 25,
          onPressed: () {
            if(usertype == '2'){
              Navigator.pop(context);
            }
            // else if(usertype=='4'|| usertype=='3'){
            //   Navigator.popAndPushNamed(
            //     context,'/choose');
            // }
          }),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications),
            color: ColorSet.primaryColor,
            iconSize: 25,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifi()),
              );
            })
      ],
    );
    //Allowed height to work with
    var newheight = (MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom);
    return Scaffold(
      floatingActionButton: ChatButton(),
      backgroundColor: ColorSet.whiteColor,
      appBar: MyAppBar,
      //Main widget in the page
      body: ListView(
        children: [
          //Top container that contains the avatar and the card
          Container(
            height: newheight * 0.20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorSet.whiteColor,
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(25), topStart: Radius.circular(25)),
            ),
            //Row has avatar as leading and the card as trailing
            child: Row(
              children: [
                //Student's avatar
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: FutureBuilder<Student>(
                      future: StudentData().SData(int.parse(code)),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          return FittedBox(
                            child: CircleAvatar(
                              backgroundImage:HttpStatus.internalServerError != 500?
                              NetworkImage('http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${snapshot.data.imagePath}'):
                              AssetImage('assets/images/student.png'),
                              radius: 35.0,
                            ),
                            fit: BoxFit.fill,
                          );
                        }
                        else if(snapshot.hasError){
                          return Text("error");
                        }
                        return CircularProgressIndicator();
                      }),
                ),
                SizedBox(
                  width: 40,
                ),
                //Container that contains the identifiction card
                Container(
                  height: 250,
                  width: 220,
                  child: Card(
                    color: ColorSet.whiteColor,
                    shadowColor: ColorSet.shadowcolour,
                    elevation: 9.0,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorSet.borderColor, width: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    //Column that contains the data of the student
                    child: Center(
                        child: FutureBuilder<Student>(
                            future: StudentData().SData(int.parse(code)),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8, top: 5),
                                      child: FittedBox(
                                        child: Text(
                                          snapshot.data.sNameEN,
                                          style: AppTextStyle.headerStyle2,
                                        ),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Stage: ${snapshot.data.stageNameEN}",
                                          style: AppTextStyle.textstyle15,
                                        ),
                                        Text(
                                          "Class:${snapshot.data.classNameEN}",
                                          style: AppTextStyle.textstyle15,
                                        ),
                                      ],
                                    ),

                                    //SOCIAL MEDIA CONTAINER
                                    Container(
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: FaIcon(
                                              FontAwesomeIcons.facebook,
                                              color: ColorSet.SecondaryColor,
                                            ),
                                            onPressed: () async{
                                              print(snapshot.data.facebook);
                                            String url = snapshot.data.facebook;
                                              try{
                                                await canLaunch(url)?await launch(url ):throw 'error';
                                              }
                                              catch(e){
                                                  Toast.show("No account was found", context,
                                                  duration:Toast.LENGTH_LONG,);
                                              }
                                            },
                                          ),
                                          IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.twitter,
                                                color: ColorSet.SecondaryColor,
                                              ),
                                              onPressed: () async{
                                                print(snapshot.data.twitter);
                                                String url = snapshot.data.twitter;
                                                try{
                                                  await canLaunch(url)?await launch(url ):throw 'error';
                                                }
                                                catch(e){
                                                Toast.show("No account was found", context,
                                                duration:Toast.LENGTH_LONG,);
                                                }
                                              }),
                                          IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.linkedinIn,
                                                color: ColorSet.SecondaryColor,
                                              ),
                                              onPressed: () async{
                                                print(snapshot.data.linkedIn);
                                                String url = snapshot.data.linkedIn;
                                                try{
                                                  await canLaunch(url)?await launch(url ):throw 'error';
                                                }
                                                catch(e){
                                                  Toast.show("No account was found", context,
                                                    duration:Toast.LENGTH_LONG,);
                                                }
                                              }),
                                          IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.instagram,
                                                color: ColorSet.SecondaryColor,
                                              ),
                                              onPressed: () async{
                                                print(snapshot.data.instgram);
                                                String url = snapshot.data.instgram;
                                                try{
                                                  await canLaunch(url)?await launch(url ):throw 'error';
                                                }
                                                catch(e){
                                                  Toast.show("No account was found", context,
                                                    duration:Toast.LENGTH_LONG,);
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("error");
                              }
                              return CircularProgressIndicator();
                            })),
                  ),
                ),
              ],
            ),
          ),
          //MAIN CONTAINER IN THE PAGE
          SizedBox(
            height: newheight * 0.007,
          ),
          Container(
            height: newheight * 0.68,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorSet.primaryColor,
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(25), topStart: Radius.circular(25)),
            ),
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.07,
                  ),
                  //COURSES CARD
                  GestureDetector(
                    onTap: () {
                     Navigator.pushNamed(context, '/subjects', arguments: LoginResponseModel(code: logInInfo.code)
                     );
                    },
                    child: Container(
                      height: constraints.maxHeight * 0.25,
                      width: constraints.maxWidth * 0.65,
                      child: Row(
                        children: [
                          Image(
                              image:
                                  AssetImage('assets/images/science-book.png')),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Courses",
                            style: AppTextStyle.headerStyle2,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                          color: ColorSet.whiteColor,
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorSet.shadowcolour,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(4, 3),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  //RECENT ASSIGNMENT
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecentAssignment()),
                      );
                    },
                    child: Container(
                      height: constraints.maxHeight * 0.25,
                      width: constraints.maxWidth * 0.65,
                      child: Row(
                        children: [
                          Image(
                              image: AssetImage('assets/images/recntassi.png')),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Recent\nAssignment",
                            style: AppTextStyle.headerStyle2,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                          color: ColorSet.whiteColor,
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorSet.shadowcolour,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(4, 3),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  //RECENT EXAMS
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecentAssignment()),
                      );
                    },
                    child: Container(
                      height: constraints.maxHeight * 0.25,
                      width: constraints.maxWidth * 0.65,
                      child: Row(
                        children: [
                          Image(image: AssetImage('assets/images/courses.png')),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Recent\nExams",
                            style: AppTextStyle.headerStyle2,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                          color: ColorSet.whiteColor,
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorSet.shadowcolour,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(4, 3),
                            ),
                          ]),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

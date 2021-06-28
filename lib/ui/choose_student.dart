import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/app_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/ui/SubjectPage.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'Home.dart';

class ChooseStudent extends StatefulWidget {
  @override
  _ChooseStudentState createState() => _ChooseStudentState();
}

class _ChooseStudentState extends State<ChooseStudent> {
  static final route = '/choose';
  LoginResponseModel logInInfo;
  List<dynamic> ChildrenCodes = new List<dynamic>();
  var studentInfo;
  var code;
  List codeList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logInInfo = ModalRoute.of(context).settings.arguments;
    ChildrenCodes = (Provider.of<APIService>(context, listen: false).children).split(",");
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
    });
    return Scaffold(
      backgroundColor: ColorSet.whiteColor,
      //Page body
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(-328.0, 268.0),
            child: Transform.rotate(
              angle: 0.3665,
              child: Container(
                width: 814.0,
                height: 709.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  gradient: LinearGradient(
                    begin: Alignment(1.12, 1.37),
                    end: Alignment(-0.21, -0.95),
                    colors: [ColorSet.primaryColor, ColorSet.whiteColor],
                    stops: [0.0, 1.0],
                  ),
                  //border: Border.all(width: 1.0, color: ColorSet.borderColor),
                ),
              ),
            ),
          ),
          Center(
            child: CarouselSlider.builder(
                itemCount:ChildrenCodes.length,
                itemBuilder: (_, int index, int realIndex) {
                  return StudentCard(context, ChildrenCodes[index]);
                },
                options: CarouselOptions(
                  height: 310,
                  autoPlay: false,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: InkWell(child: Text(" You are a teacher? \nCheck your account",style: AppTextStyle.headerStyle2,),
              onTap: (){Navigator.pushNamed(context, '/teacherProfile',);},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container StudentCard(BuildContext context, var childcode) {
    return  Container(
      height: 400,
      width: 400,
      //CARD AND AVATAR STACK
      child: Stack(
        children: [
          Center(
            child: Card(
              color: ColorSet.whiteColor,
              shadowColor: ColorSet.shadowcolour,
              elevation: 9.0,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: ColorSet.borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 200,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: FutureBuilder<Student>(
                    future: StudentData().SData(int.parse(childcode)),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        //print("from home ${Provider.of<StudentData>(context,listen: true).studentcode}");
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "${snapshot.data.sNameAR}",
                                style: AppTextStyle.headerStyle2,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Stage : ${snapshot.data.stageNameAR} \nClass: ${snapshot.data.classNameAR}",
                                  style: AppTextStyle.textstyle15,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/BNV',
                                        arguments: Student(
                                          studentCode: snapshot.data.studentCode,
                                          userCode: snapshot.data.userCode,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Go",
                                      style: TextStyle(color: ColorSet.primaryColor),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorSet.SecondaryColor,
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      else if(snapshot.hasError){
                        return Text("error");
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, -0.0001),
            child: Align(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/student.png'),
                radius: 50.0,
              ),
              alignment: Alignment.topCenter,
              // alignment: FractionalOffset(0.5, 0.39),
            ),
          ),
        ],
      ),
    );
   }
}

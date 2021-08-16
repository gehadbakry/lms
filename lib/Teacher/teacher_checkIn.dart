import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_pro/Teacher/teacher_students_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/app_style.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'attendence_behaviour.dart';

class CheckIn extends StatefulWidget {
  final int courseCode;
  final int dayCode;
  final String startTime;
  final String endTime;
  final String className;
  final String stageName;
  final String subjectName;

  const CheckIn({Key key, this.courseCode, this.dayCode,this.endTime,this.startTime,this.className,this.stageName,this.subjectName}) : super(key: key);

  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  bool isChecked = false;
  String studentTableCode ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Check into class",
        style: AppTextStyle.complaint,
      )),
      content: Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Stage Name: ",style: AppTextStyle.headerStyle2,),
                Text('${widget.stageName}',style: AppTextStyle.textstyle15,)
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Stage Name: ",style: AppTextStyle.headerStyle2,),
                Text('${widget.className}',style: AppTextStyle.textstyle15,)
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Subject: ",style: AppTextStyle.headerStyle2,),
                Text('${widget.subjectName}',style: AppTextStyle.textstyle15,)
              ],
            ),
            SizedBox(height: 30),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('From:\n${widget.startTime}',style: AppTextStyle.headerStyle2,),
                  VerticalDivider(
                      color: Colors.black,
                      width: 1,
                      thickness: 1,
                      endIndent: 0.5),
                  Text('To:\n${widget.endTime}',style: AppTextStyle.headerStyle2)
                ],
              ),
            ),
            SizedBox(height: 30),
            CheckboxListTile(
                title: Text("Check In?",style: AppTextStyle.headerStyle2,),
                value: isChecked,
                onChanged: (val) {
                  setState(() {
                    isChecked = val;
                  });
                }),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Back",
            style: TextStyle(color: ColorSet.SecondaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text(
            "Go",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.red
          ),
          onPressed: () {
           if(isChecked == false){
             Toast.show("Please check the box",context,duration:Toast.LENGTH_LONG);
           }
           else{
             goToAttendence(widget.courseCode, widget.dayCode);
           }
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
  }
   goToAttendence(int courseCode,int dayCode) async {
    var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostTeacherClassRoomCheckIn");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['school_courses_table_setup_stages_details_code'] = courseCode.toString();
   // request.fields['school_courses_table_setup_stages_details_code'] = '27';
    request.fields['uc'] =Provider.of<APIService>(context, listen: false).usercode;
    //request.fields['uc'] ='1';
    request.fields['day_code'] =dayCode.toString();
    //request.fields['day_code'] ='6';


    request.headers.addAll({
    'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      studentTableCode = await response.stream.bytesToString();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AttendBehavTabs(className:widget.className ,stageName:widget.stageName ,tableCode: int.parse(studentTableCode),)),
      );
    print("posted");
    }
    else{
    print("Not Posted");
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/online_exam_info.dart';
import 'package:lms_pro/models/online_exam.dart';
import 'package:lms_pro/models/quiz.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../app_style.dart';

class OnlineExam extends StatefulWidget {
  @override
  _OnlineExamState createState() => _OnlineExamState();
}

class _OnlineExamState extends State<OnlineExam> {
  var code;
  var subjectCode;
  Subject subject;
  var examCode;
  var setExamCode;
  var args;
  var usercode;
  void initState() {
    subject = Subject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    setState(() {
      if (Provider.of<APIService>(context, listen: false).usertype == "2"){
        code = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
        subjectCode = args[0].subjectCode;
      }
      else if(Provider.of<APIService>(context, listen: false).usertype == "3" ||Provider.of<APIService>(context, listen: false).usertype == "4" ){
        code = (args[1].studentCode).toString();
        usercode = args[1].userCode;
        subjectCode = args[0].subjectCode;
      }
    }
    );
    // subject = ModalRoute.of(context).settings.arguments;
    // setState(() {
    //   code = Provider.of<APIService>(context, listen: false).code;
    //   subjectCode = subject.subjectCode;
    // });
    return FutureBuilder<List<OnlineExams>>(
       future: OnlineExamInfo().getOnlineExam(int.parse(code), subjectCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return GroupedListView<OnlineExams, int>(
                elements: snapshot.data.toList(),
                groupBy: (OnlineExams e) => e.examCode,
                groupHeaderBuilder: (OnlineExams e) =>  Padding(
                  padding: const EdgeInsets.only(top: 15 , bottom: 10 ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20 ,left:20),
                    child: GestureDetector(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: ColorSet.whiteColor,
                          borderRadius:BorderRadius.all(Radius.circular(15)),
                          boxShadow:[ BoxShadow(
                            color: ColorSet.shadowcolour,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(4, 3),
                          ),]
                        ),
                        child: ListTile(
                          leading:
                              Text('${e.examName} ',style: AppTextStyle.headerStyle2,),
                          title:Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Text('${(e.publishDate).substring(0,10)}',style: AppTextStyle.subText,),
                                SizedBox(height: 5,),
                                Text('${e.studentMark} / ${e.totalGrade}',style: AppTextStyle.complaint,),
                              ],
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Icon(Icons.arrow_forward_ios,color: ColorSet.inactiveColor,),
                          ),
                        ),
                      ),
                      onTap: () => alertDialog(e.examCode , e.examName),
                    ),
                  ),
                ),
                itemBuilder: (context, OnlineExams e){
                  return null;
                },
                order: GroupedListOrder.ASC,
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text("No Exams was found",style: AppTextStyle.headerStyle2,),
              );
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("error"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
  alertDialog(var newCode , String examName) {
    var alert = FutureBuilder<List<OnlineExams>>(
        future: OnlineExamInfo().getOnlineExam(int.parse(code), subjectCode),
        builder: (context, snapshot) {
    if (snapshot.hasData) {
      return  AlertDialog(
        title: Column(
          children: [
            Text(examName , style: AppTextStyle.headerStyle2,),
            Center(child: Text("Lessons" , style: AppTextStyle.complaint,)),
          ],
        ),
        content: Container(
          height: MediaQuery.of(context).size.height*0.3,
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder:(context , index){
            if(snapshot.data[index].examCode == newCode){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,size: 5,color: ColorSet.primaryColor,),
                    SizedBox(width: 5,),
                    Center(child: Text('${snapshot.data[index].lessonNameAr}' , style: AppTextStyle.textstyle15,)),
                  ],
                );
            }
            return Text("");
          } ),
        ),
        actions: [
          FlatButton(
            child: Text(
              "Okay",
              style: TextStyle(color: ColorSet.SecondaryColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
      );
    }
    else if(snapshot.hasError){
      return Center(
        child: Text("error"),
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
        }
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
  }

import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/recents_info.dart';
import 'package:lms_pro/api_services/subjects_info.dart';
import 'package:lms_pro/models/recents.dart';
import 'package:lms_pro/utils/ChatButton.dart';

import '../app_style.dart';
import 'NotifiPage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class RExams extends StatefulWidget {
  @override
  _RExamsState createState() => _RExamsState();
}

class _RExamsState extends State<RExams> {
  var assignmentCode;
  var countAssign;
  var code;
  var userCode;

  @override
  Widget build(BuildContext context) {
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            Navigator.pop(
              context,
            );
          }),
      centerTitle: true,
      title: Text("Recent Exams", style: AppTextStyle.headerStyle),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications),
            color: ColorSet.whiteColor,
            iconSize: 25,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifi()),
              );
            })
      ],
    );
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
      userCode = Provider.of<APIService>(context, listen: false).usercode;
    });
    countAssign = 0;
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: MyAppBar,
      body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: ColorSet.whiteColor,
          ),
          padding: EdgeInsets.only(top: 10),
          child: FutureBuilder<List<Recents>>(
            future: RecentsInfo().getRecents(int.parse(userCode)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GroupedListView<Recents, int>(
                  elements: snapshot.data.toList(),
                  groupBy: (Recents e) => e.examCode,
                  groupHeaderBuilder: (Recents e) {
                    return e.typeRecent == 1
                        ? Padding(
                          padding:EdgeInsets.only(right: 20 ,left:20,bottom:10 ),
                          child: GestureDetector(
                              child: Container(
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
                                  title:  Container(
                                    width: 130,
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('${e.subjectNameAr} ',style: AppTextStyle.headerStyle2,maxLines: 1,)),
                                        SizedBox(height: 5,),
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text('${e.examName} ',style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w500 , color: ColorSet.inactiveColor),maxLines: 2,)),
                                        SizedBox(height: 5,),
                                        Text('Result: ${e.studentExamMark} / ${e.totalExamMark}',style: AppTextStyle.complaint,),
                                      ],
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text('${DateFormat.yMd().format(DateTime.now())}',
                                        style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w500 , color: ColorSet.SecondaryColor),maxLines: 1,),
                                      SizedBox(height: 5,),
                                      Icon(Icons.arrow_forward_ios,color: ColorSet.inactiveColor,),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () => alertDialog(e.examCode, e.examName , e.subjectNameAr ,e.studentExamMark),
                            ),
                        )
                        : Text("I am here");
                  },
                  itemBuilder: (context, Recents e) {
                    return null;
                  },
                  order: GroupedListOrder.ASC,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("error"),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
      floatingActionButton: ChatButton(),
    );
  }

  void alertDialog(var NewCode, var NewName ,var newSubName ,var mark) {
    var alert = FutureBuilder<List<Recents>>(
        future: RecentsInfo().getRecents(int.parse(userCode)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AlertDialog(
              title:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(newSubName, style: AppTextStyle.headerStyle2,maxLines: 2,)),
                  Text(
                      NewName,
                      style: TextStyle(fontSize: 14,color: ColorSet.SecondaryColor),maxLines: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10 ,right: 5 ,left:5),
                    child: Divider(height: 1,thickness: 1,),
                  ),
                ],
              ),
              content: Container(
                height: MediaQuery.of(context).size.height*0.2,
                child: Column(
                  children: [
                    Text("Lessons",style: AppTextStyle.complaint,),
                    SizedBox(height: 5,),
                    Expanded(
                      child: ListView.builder(
                         itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data[index].examCode == NewCode) {
                              if(snapshot.data[index].examLessonNameAr!=null){
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.circle,size: 5,color: ColorSet.primaryColor,),
                                      SizedBox(width: 5,),
                                      Text(
                                        '${snapshot.data[index].examLessonNameAr}',
                                        style: AppTextStyle.textstyle15,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else if(snapshot.data[index].examLessonNameAr==null){
                                return Center(
                                  child: Text("No lessons to show",style: TextStyle(fontSize: 15 ,color: ColorSet.inactiveColor , fontWeight: FontWeight.bold),),
                                );
                              }
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
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
          } else if (snapshot.hasError) {
            return Center(
              child: Text("error"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/NotifiCountAll.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/recents_info.dart';
import 'package:lms_pro/api_services/subjects_info.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/recents.dart';
import '../Chat/ChatButton.dart';

import '../app_style.dart';
import 'NotifiPage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
class RecentAssignment extends StatefulWidget {
  @override
  _RecentAssignmentState createState() => _RecentAssignmentState();
}

class _RecentAssignmentState extends State<RecentAssignment> {
  var assignmentCode;
  var countAssign;
  var code;
  var usercode;
  Student student;
  @override
  Widget build(BuildContext context) {
    student = ModalRoute.of(context).settings.arguments;
    setState(() {
      if (Provider.of<APIService>(context, listen: false).usertype == "2"){
        code = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
      }
      else if(Provider.of<APIService>(context, listen: false).usertype == "3" ||Provider.of<APIService>(context, listen: false).usertype == "4" ){
        code = (student.studentCode).toString();
        usercode = student.userCode.toString();
      }
    }
    );
    Widget MyAppBar = AppBar (
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
              child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: FutureBuilder<AllCount>(
                    future: NotificationAllCount().getAllNotificationCount(
                        usercode.runtimeType == String
                            ? int.parse( usercode)
                            :  usercode),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            snapshot.data.allNotification,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('error'),
                        );
                      }
                      return FittedBox(
                        fit: BoxFit.fill,
                        child: CircularProgressIndicator(),
                      );
                    },
                  )),
            )
          ],
        ),
      ],
    );
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
            future: RecentsInfo().getRecents(int.parse(usercode)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GroupedListView<Recents, int>(
                  elements: snapshot.data.toList(),
                  groupBy: (Recents e) => e.assignmentCode,
                  groupHeaderBuilder: (Recents e) {
                    return e.typeRecent == 2
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
                                      child: Text('${e.assignsubjectNameAr} ',style: AppTextStyle.headerStyle2,maxLines: 1,)),
                                  SizedBox(height: 5,),
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('${e.assignmentName} ',style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w500 , color: ColorSet.inactiveColor),maxLines: 2,)),
                                  SizedBox(height: 5,),
                                  Text('Result: ${e.assignmentMark} / ${e.totalAssignmentGrade}',style: AppTextStyle.complaint,),
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
                        onTap: () => alertDialog(e.assignmentCode, e.assignmentName , e.assignsubjectNameAr ,e.assignmentMark),
                      ),
                    )
                        : Container(height: 0,width: 0,);
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
      floatingActionButton: ChatButton(userCode: usercode,code: code,),
    );
  }
  void alertDialog(var NewCode, var NewName ,var newSubName ,var mark) {
    var alert = FutureBuilder<List<Recents>>(
        future: RecentsInfo().getRecents(int.parse(usercode)),
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
                            if (snapshot.data[index].assignmentCode == NewCode) {
                              if(snapshot.data[index].assignLessonNameAr!=null){
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.circle,size: 5,color: ColorSet.primaryColor,),
                                      SizedBox(width: 5,),
                                      Text(
                                        '${snapshot.data[index].assignLessonNameAr}',
                                        style: AppTextStyle.textstyle15,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else if(snapshot.data[index].assignLessonNameAr==null){
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

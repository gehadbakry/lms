import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/teacher_api/getTeacherProfile.dart';
import 'package:lms_pro/teacher_models/teacher_profile_model.dart';
class TeacherClasses extends StatefulWidget {
  final int code;

  const TeacherClasses({Key key, this.code}) : super(key: key);

  @override
  _TeacherClassesState createState() => _TeacherClassesState();
}

class _TeacherClassesState extends State<TeacherClasses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        title: Text("My classes",style: AppTextStyle.headerStyle,),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ColorSet.whiteColor,
          borderRadius:BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15) ),
        ),
        child:  FutureBuilder<List<TeacherModel>>(
            future: TeacherProfileInfo().getTeacherProfileInfo(widget.code),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ////GROUP THE INFO FROM THE API USING TEACHER NAME AND USE THE PICTURE
                return GroupedListView<TeacherModel, String>(
                  elements: snapshot.data.toList(),
                  groupBy: (TeacherModel e) => e.phaseNameEn,
                  groupHeaderBuilder: (TeacherModel e) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10,left: 20),
                        child: Text('${e.phaseNameEn}',style: AppTextStyle.complaint,),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.55,
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  itemBuilder: (context, TeacherModel e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10,top: 20,right: 30,left: 30),
                      child: Container(
                        height: 100,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Stage name: ",style: AppTextStyle.headerStyle2,),
                                Text("${e.StageNameEn}",style: AppTextStyle.textstyle15,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Class: ",style: AppTextStyle.headerStyle2,),
                                Text("${e.classNameEn}",style: AppTextStyle.textstyle15,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  order: GroupedListOrder.ASC,
                );
              } else if (snapshot.hasError) {
                return Text("error");
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

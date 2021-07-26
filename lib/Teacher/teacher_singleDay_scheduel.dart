import 'package:flutter/material.dart';
import 'package:lms_pro/teacher_api/getTeacherScheduel.dart';
import 'package:lms_pro/teacher_models/teacher_scheduel.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_style.dart';

class SingleDayScheduel extends StatefulWidget {
  final int dayCode;
  final String dayNameEn;
  final String dayNameAR;
  const SingleDayScheduel({Key key, this.dayCode,this.dayNameEn,this.dayNameAR}) : super(key: key);

  @override
  _SingleDayScheduelState createState() => _SingleDayScheduelState();
}

class _SingleDayScheduelState extends State<SingleDayScheduel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        title: Text("${widget.dayNameEn}",style: AppTextStyle.headerStyle,),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ColorSet.whiteColor,
          borderRadius:BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15) ),
        ),
        child: FutureBuilder<List<TeacherScheduel>>(
          future: TeacherScheduelInfo()
              .getTeacherScheduelInfo(30, 17, widget.dayCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return snapshot.data[index].dayCode == widget.dayCode
                        ? Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: TimelineTile(
                              indicatorStyle: IndicatorStyle(
                                color: ColorSet.primaryColor,
                                indicatorXY: 0.4,
                                drawGap: true,
                              ),
                              endChild: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      snapshot.data[index].subjectNameEN,
                                      style: AppTextStyle.headerStyle2,
                                    ),
                                    subtitle: Text(
                                      snapshot.data[index].teacherNameEn,
                                      style: AppTextStyle.subtextgrey,
                                    ),
                                    trailing: Text(
                                      "${(snapshot.data[index].courseStart).substring(0, 5)} : ${(snapshot.data[index].courseEnd).substring(0, 5)}",
                                      style: AppTextStyle.subText,
                                    ),
                                  ),
                                ],
                              ),
                              isFirst: index == 0 ? true : false,
                              isLast: index == snapshot.data.length - 1
                                  ? true
                                  : false,
                            ),
                          )
                        : Center(
                            child: Text("No scheduel today"),
                          );
                  });
            } else if (snapshot.hasError) {
              return Text("");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

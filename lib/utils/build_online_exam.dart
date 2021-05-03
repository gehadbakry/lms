import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/online_exam_info.dart';
import 'package:lms_pro/models/online_exam.dart';
import 'package:lms_pro/models/quiz.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';

class OnlineExam extends StatefulWidget {
  @override
  _OnlineExamState createState() => _OnlineExamState();
}

class _OnlineExamState extends State<OnlineExam> {
  var code;
  var subjectCode;
  Subject subject;

  void initState() {
    subject = Subject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context).settings.arguments;
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
      subjectCode = subject.subjectCode;
    });
    return FutureBuilder<List<OnlineExams>>(
        future: OnlineExamInfo().getOnlineExam(int.parse(code), subjectCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Card(
                        shadowColor: ColorSet.shadowcolour,
                        elevation: 9.0,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: ColorSet.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.only( bottom: 3),
                                    child: Text(
                                      snapshot.data[index].examName,
                                      style: AppTextStyle.headerStyle2,
                                    ),
                                    //SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only( left: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data[index].lessonNameEn}",
                                          style: AppTextStyle.subtextgrey,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Text(
                                        (snapshot.data[index].publishDate)
                                            .substring(0, 10),
                                        style: AppTextStyle.subText,
                                      ),

                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                                    child: Text("This Exam was taken on ${(snapshot.data[index].publishDate).substring(0, 10)} at ${(snapshot.data[index].publishTime).substring(0,5)} and your result is  ${snapshot.data[index].studentMark}/${snapshot.data[index].totalGrade}. ",
                                      style: AppTextStyle.textstyle15,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  });
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text("No Exams was found"),
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
}

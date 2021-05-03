
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/quiz_info.dart';
import 'package:lms_pro/api_services/rank_info.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/quiz.dart';
import 'package:lms_pro/models/student_rank.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
class QuizPageDetails extends StatefulWidget {
  @override
  _QuizPageDetailsState createState() => _QuizPageDetailsState();
}

class _QuizPageDetailsState extends State<QuizPageDetails> {
  Subject subject;
  var code;
  var subjectCode;
  Quiz quiz;
  var studentRank;
  var quizcode;
  var StudentProvider;
  String studentN;
  @override
  void initState() {
    subject = Subject();
    quiz = Quiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context).settings.arguments;
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
      studentN = Provider.of<StudentData>(context ,listen: false).NameEn;
      subjectCode = subject.subjectCode;
    });
    return FutureBuilder<List<Quiz>>(
       future: QuizInfo().getQuiz(int.parse(code), subjectCode),
        //future: QuizInfo().getQuiz(969, 35),
        builder: (context , snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length >0 ){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: Card(
                        shadowColor: ColorSet.shadowcolour,
                        elevation: 9.0,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: ColorSet.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 5),
                                child:
                                    Text(
                                      snapshot.data[index].quizName,
                                      style: AppTextStyle.headerStyle2,
                                    ),
                                    //SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                              ),
                              subtitle:  Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 8,left: 5),
                                child: Text(
                                  "Your result is ${snapshot.data[index].grade}/${snapshot.data[index].totalQuizGrade}",
                                  style: AppTextStyle.subtextgrey,
                                  maxLines: 2,
                                ),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (snapshot.data[index].date).substring(0,10),
                                    style: AppTextStyle.subText,
                                  ),
                                  Spacer(),
                                  Text(
                                    "Show Rank",
                                    style: AppTextStyle.subText,
                                  ),
                                ],
                              ),
                              onTap: () => alertDialog(context ,
                                  snapshot.data[index].quizCode ,
                                  snapshot.data[index].studentRank,
                              snapshot.data[index].studentMark,
                                snapshot.data[index].totalQuizGrade,
                                snapshot.data[index].quizName,
                                studentN
                              ),

                            );
                          },
                        ),
                      ),
                    );
                  });
            }
            else if(snapshot.data.length == 0){
              return Center(
                child: Text("No quizzes was found"),
              );
            }
          }
          else if(snapshot.hasError){
            return Center(child:Text("error"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

   alertDialog(BuildContext context , var quizc , var studentrank,var studentMark , var total , var quizName , String studentname) {
    var alert = FutureBuilder<List<Rank>>(
        future: RankInfo().getRank(quizc, int.parse(code)),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return AlertDialog(
              title: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              studentname,
                              style: AppTextStyle.textstyle20,
                              maxLines: 1,
                            )),
                      ),
                      subtitle: Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                quizName,
                                style: AppTextStyle.subText,
                              )),
                          Spacer(),
                          Column(
                            children: [
                              FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Result: ${studentMark} / ${total} ",
                                      style: TextStyle(fontSize: 12 , color: ColorSet.inactiveColor),
                                    ),
                                  )),
                              FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Rank: $studentrank ",
                                      style: TextStyle(fontSize: 12 , color: ColorSet.inactiveColor),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Divider(height: 1,thickness: 2,),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: Text("Statistics" , style: TextStyle(fontSize: 15 , color: Colors.red),),
                          ),
                          Row(
                            children: [
                              Text("Students",style: TextStyle(fontSize: 14,color: ColorSet.inactiveColor),),
                              Spacer(),
                              Text("Marks",style: TextStyle(fontSize: 14,color: ColorSet.inactiveColor),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              content:  Container(
                height: MediaQuery.of(context).size.height*0.25,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10,left: 12),
                        child: Row(
                          children: [
                            Text("${snapshot.data[index].noStudent}",style: AppTextStyle.textstyle15,),
                            Spacer(),
                            Text("${snapshot.data[index].studentMark}",style: AppTextStyle.textstyle15,),
                          ],
                        ),
                      );
                    }),
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
        });

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
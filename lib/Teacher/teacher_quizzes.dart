import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/teacher_api/getTeacherQuizzes.dart';
import 'package:lms_pro/teacher_models/teacher_quiz_model.dart';
import 'package:provider/provider.dart';

class TeacherQuizzes extends StatefulWidget {
  final stageSubjectCode;

  const TeacherQuizzes({Key key, this.stageSubjectCode}) : super(key: key);

  @override
  _TeacherQuizzesState createState() => _TeacherQuizzesState();
}

class _TeacherQuizzesState extends State<TeacherQuizzes> {
  int code;
  int SchoolYear;
  int subjestStageCode;

  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      subjestStageCode = widget.stageSubjectCode;
    });
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 13),
            width:140,
            child: FloatingActionButton(
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45.0))
              ),
              backgroundColor: ColorSet.SecondaryColor,
              child:Center(
                child: Text("Students' Marks",style:TextStyle(fontSize: 14,color: ColorSet.whiteColor)),
              ),
              onPressed: (){},
            ),
          ),
          SizedBox(width: 5,),
          Container(
            width:110,
            child: FloatingActionButton(
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45.0))
              ),
              backgroundColor: ColorSet.primaryColor,
              child:Center(
                child: Text("Add a quiz",style:TextStyle(fontSize: 14,color: ColorSet.whiteColor)),
              ),
              onPressed: (){},
            ),
          ),
        ],
      ),
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
        title: Text(
          "Quizzes",
          style: AppTextStyle.headerStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ColorSet.whiteColor,
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: FutureBuilder<List<TeacherQuiz>>(
              future: TeacherQuizzesInfo().getTeacherQuizzesInfo(code, 236),
              //future: TeacherQuizzesInfo().getTeacherQuizzesInfo(code, subjestStageCode),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 7, bottom: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: ColorSet.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset:
                                  Offset(4, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                                leading: Text(
                                  snapshot.data[index].quizName,
                                  style: AppTextStyle.headerStyle2,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: ColorSet.primaryColor,
                                ),
                                onTap: () => showQuizzesInfo(snapshot.data[index].quizName,
                                    snapshot.data[index].totalGrade,
                                    snapshot.data[index].noOfStudents,
                                    snapshot.data[index].date)
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: ColorSet.primaryColor,) ),
                            IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.red,)),
                          ],
                        ),
                      ],
                    );
                  });

                } else if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  showQuizzesInfo(var QuizName ,var TotalQuizGrade ,var NoOfStudents ,var quizDate){
    var date = DateTime.parse(quizDate);
    var alert = AlertDialog(
      title: Center(
          child: Row(
            children: [
              Text('${QuizName}',style: AppTextStyle.headerStyle2,),
              Spacer(),
              Text('${DateFormat('dd-MM-yyy').format(date)}',style: AppTextStyle.subText,),
            ],
          )),
      content: Container(
        height:MediaQuery.of(context).size.height*0.2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Grade: ",style: AppTextStyle.headerStyle2,),
                  Text("${TotalQuizGrade}",style: AppTextStyle.textstyle15,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No. of students: ",style: AppTextStyle.headerStyle2,),
                  Text("${NoOfStudents}",style: AppTextStyle.textstyle15),
                ],
              ),
            ],
          ),
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
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

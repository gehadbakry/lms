import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/teacher_api/getTeacherQuizzes.dart';
import 'package:lms_pro/teacher_models/teacher_quiz_model.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

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
  String userCode;
  static DateTime selecteddate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    setState(() {
      userCode = Provider.of<APIService>(context, listen: false).usercode;
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      subjestStageCode = widget.stageSubjectCode;
    });

    return Scaffold(
      floatingActionButton: Container(
        width: 110,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(45.0))),
          backgroundColor: ColorSet.primaryColor,
          child: Center(
            child: Text("Add a quiz",
                style: TextStyle(fontSize: 14, color: ColorSet.whiteColor)),
          ),
          onPressed: ()=>createQuiz(),
        ),
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
                  return snapshot.data.length==0?Text("No quizzes were found",style: AppTextStyle.headerStyle2,):
                  GroupedListView<TeacherQuiz, int>(
                    elements: snapshot.data.toList(),
                      groupBy: (TeacherQuiz e) => e.quizCode,
                      groupHeaderBuilder: (TeacherQuiz e)=>Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 7, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                color: ColorSet.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(
                                        4, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                  leading: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(e.quizName,
                                      style: AppTextStyle.headerStyle2,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: ColorSet.primaryColor,
                                  ),
                                  onTap: () => showQuizzesInfo(e.quizName, e.totalGrade, e.noOfStudents, e.date)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add, color: ColorSet.SecondaryColor,)),
                              IconButton(
                                  onPressed: () => editQuiz(e.quizCode,e.quizName, e.totalGrade, e.date),
                                  icon: Icon(Icons.edit, color: ColorSet.primaryColor,)),
                              IconButton(onPressed: () => deleteQuiz(e.quizCode),
                                  icon: Icon(Icons.delete, color: Colors.red,)),
                            ],
                          ),
                        ],
                      ),
                    itemBuilder: (context, TeacherQuiz e) =>null,
                    order: GroupedListOrder.DESC,
                  );
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

  showQuizzesInfo(var QuizName, var TotalQuizGrade, var NoOfStudents, var quizDate) {
    var date = DateTime.parse(quizDate);
    var alert = AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '${QuizName}',
          style: AppTextStyle.headerStyle2,
        ),
      ),
      SizedBox(height: 5,),
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '${DateFormat('dd-MM-yyy').format(date)}',
          style: AppTextStyle.subText,
        ),
      ),
          Container(
            width: MediaQuery.of(context).size.width *
                0.65,
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Grade: ",
                    style: AppTextStyle.headerStyle2,
                  ),
                  Text(
                    "${TotalQuizGrade}",
                    style: AppTextStyle.textstyle15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No. of students: ",
                    style: AppTextStyle.headerStyle2,
                  ),
                  Text("${NoOfStudents}", style: AppTextStyle.textstyle15),
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

  createQuiz() {
    TextEditingController quizName = TextEditingController();
    TextEditingController quizMark = TextEditingController();
    var alert = AlertDialog(
      title: Center(child: Text("Add a new quiz", style: AppTextStyle.headerStyle2,)),
      content: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: quizName,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12,color: ColorSet.inactiveColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.borderColor),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.primaryColor),
                    ),
                    hintText: "Quiz's name"

                ),

              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: quizMark,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12,color: ColorSet.inactiveColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.borderColor),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.primaryColor),
                    ),
                    hintText: "Quiz total mark"

                ),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: RaisedButton(
               child: Text("Pick you Date!", style:AppTextStyle.headerStyle,),
              color: ColorSet.primaryColor,
              onPressed:() => datePicker(context),
             ),
          ),
          ElevatedButton(onPressed: ()async{
            print(quizName.text);
            print(selecteddate);
            print(code);
            print(quizMark.text);
            print(subjestStageCode);
            print(userCode);
            var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostQuizCreate");
            var request = new http.MultipartRequest("POST", uri);
             request.fields['quize_name'] = quizName.text.isEmpty?"Unknown name":quizName.text;
            request.fields['quize_date'] =selecteddate==null?DateTime.now().toString():selecteddate.toString();
            request.fields['teacher_code'] =code.toString();
            request.fields['quize_mark'] =quizMark.text.isEmpty?"No marks were assigned":quizMark.text;
            // request.fields['stage_subject_code'] =subjestStageCode.toString();
            request.fields['stage_subject_code'] ='236';
            request.fields['user_insert_code'] =userCode;
            request.fields['classes'] ='2034,2045';

            request.headers.addAll({
              'Content-Type': 'multipart/form-data',
            });

            var response = await request.send();
            print(response.statusCode);
            if (response.statusCode == 200) {
              Toast.show("Quiz was Posted",context,duration:Toast.LENGTH_LONG);
              print("posted");
            }
            else{
              print("Not Posted");
            }
          },
            child:  Text("Save and upload",style: AppTextStyle.headerStyle,),
            style: ElevatedButton.styleFrom(
                primary: ColorSet.SecondaryColor
            ),)
          // Text(
          //   "${DateFormat('yyyy-MM-dd ').format( selecteddate)}",
          //   style: TextStyle(fontSize: 40, color: Colors.blue),
          // ),
        ],
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
  editQuiz(var quizCode,var quizname ,var quizmarks ,var quizDate){
    TextEditingController quizName = TextEditingController();
    TextEditingController quizMark = TextEditingController();
    var alert = AlertDialog(
      title: Column(
        children: [
          Center(child: Text("Edit quiz", style: AppTextStyle.headerStyle2,)),
          Center(child: FittedBox(
              fit:BoxFit.scaleDown,
              child: Text("${quizname}", style: AppTextStyle.headerStyle2,))),
        ],
      ),
      content: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: quizName,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12,color: ColorSet.inactiveColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.borderColor),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.primaryColor),
                    ),
                    hintText: "Quiz's name"

                ),

              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: quizMark,
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 12,color: ColorSet.inactiveColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.borderColor),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorSet.primaryColor),
                    ),
                    hintText: "Quiz total mark"

                ),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: RaisedButton(
              child: Text("Pick you Date!", style:AppTextStyle.headerStyle,),
              color: ColorSet.primaryColor,
              onPressed:() => datePicker(context),
            ),
          ),
          ElevatedButton(
            onPressed: ()async{
            quizMark.text.isEmpty? Toast.show("Enter a new Grade",context,duration:Toast.LENGTH_LONG):Container(height: 0,width: 0,);
            var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostQuizEdit");
            var request = new http.MultipartRequest("POST", uri);
            request.fields['quize_name'] = quizName.text.isEmpty?quizname.toString():quizName.text;
            request.fields['quize_date'] =selecteddate==null?quizDate:selecteddate.toString();
            request.fields['teacher_code'] =code.toString();
            request.fields['quize_mark'] =quizMark.text.isEmpty?quizmarks.toString():quizMark.text;
            // request.fields['stage_subject_code'] =subjestStageCode.toString();
            request.fields['stage_subject_code'] ='236';
            request.fields['user_insert_code'] =userCode;
            request.fields['classes'] =' 2034,2045';
            request.fields['quize_code'] =quizCode.toString();

            request.headers.addAll({
              'Content-Type': 'multipart/form-data',
            });

            var response = await request.send();
            print(response.statusCode);
            if (response.statusCode == 200) {
              Toast.show("Quiz was Edited",context,duration:Toast.LENGTH_LONG);
              print("posted");
            }
            else{
              print("Not Posted");
            }
          },
            child:  Text("Save and upload",style: AppTextStyle.headerStyle,),
            style: ElevatedButton.styleFrom(
                primary:ColorSet.SecondaryColor
            ),)
          // Text(
          //   "${DateFormat('yyyy-MM-dd ').format( selecteddate)}",
          //   style: TextStyle(fontSize: 40, color: Colors.blue),
          // ),
        ],
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
  deleteQuiz(var quizCode) async {
    var uri = Uri.parse(
        "http://169.239.39.105/lms_api2/api/TeacherApi/PostQuizDelete");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['quize_code'] = quizCode.toString();

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      Toast.show("Material was deleted", context, duration: Toast.LENGTH_LONG);
      print("delete");
    } else {
      print("Not deleted");
    }
  }

  Future<void> datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selecteddate)
      setState(() {
        selecteddate = picked;
      });
      print(selecteddate);
  }
}

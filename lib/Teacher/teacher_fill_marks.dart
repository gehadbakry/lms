import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherStudentsMarks.dart';
import 'package:lms_pro/teacher_models/teacher_students_marks.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class FillStudentsMarks extends StatefulWidget {
  final int quizCode;
  final String quizName;

  const FillStudentsMarks({Key key, this.quizCode,this.quizName}) : super(key: key);
  @override
  _FillStudentsMarksState createState() => _FillStudentsMarksState();
}

class _FillStudentsMarksState extends State<FillStudentsMarks> {
  TextEditingController mark = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        title:Text("${widget.quizName}",style: AppTextStyle.headerStyle,),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<List<StudentsMarksList>>(
          //future: TeacherStudentsMarksInfo().getTeacherStudentsMarksInfo(1559),
          future: TeacherStudentsMarksInfo().getTeacherStudentsMarksInfo(widget.quizCode),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 5),
                      child:
                      Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/student.png'),
                              radius: 23,
                            ),
                            subtitle: Column(
                              children: [
                                Text('${snapshot.data[index].nameEN}',style: AppTextStyle.headerStyle2,maxLines: 2,),
                                Text('Mark: ${snapshot.data[index].mark}',style: AppTextStyle.textstyle15),
                              ],
                            ),
                            trailing: IconButton(onPressed: (){},
                                icon: Icon(Icons.edit,color: Colors.red,)),
                            onTap:  ()=>writeMark(snapshot.data[index].nameEN,snapshot.data[index].studentCode),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.8,
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            else if(snapshot.hasError){
              return Center(
                child: Text("Error"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
  writeMark(String studentName,int studentCode){
    var alert = AlertDialog(
      title: Center(child: Text("Student's Mark",style: AppTextStyle.headerStyle2,)),
      content:Container(
        height: MediaQuery.of(context).size.height*0.3,
        child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${studentName}",style: AppTextStyle.textstyle15,textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: mark,
                        maxLines: 1,
                        decoration: InputDecoration.collapsed(hintText: "Enter your Mark here",hintStyle: AppTextStyle.subtextgrey),
                      ),
                    )
                ),
              ],
            )
        ),
      ),
      actions:[
        FlatButton(
          child: Text(
            "Back",
            style: TextStyle(color: ColorSet.SecondaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
            child: Text(
              "Post",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => postStudentMark(studentCode,mark.text)
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
  postStudentMark(int studentCode,String mark) async {
    var uri =  Uri.parse("http://169.239.39.105/lms_api2//api/TeacherApi/PostQuizStudentSaveMarks");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['quiz_code'] =widget.quizCode.toString();
    request.fields['user_code'] =Provider.of<APIService>(context, listen: false).usercode;
    request.fields['student_code'] =studentCode.toString();
    request.fields['mark'] =mark;


    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      Toast.show("Mark Posted",context,duration:Toast.LENGTH_LONG);
      print("posted");
    }
    else{
      Toast.show("Mark wasn't Posted",context,duration:Toast.LENGTH_LONG);
      print("Not Posted");
    }

  }
}

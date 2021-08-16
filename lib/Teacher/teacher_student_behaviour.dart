import 'package:flutter/material.dart';
import 'package:lms_pro/teacher_api/getTeacherClassStudentList.dart';
import 'package:lms_pro/teacher_models/teacher_student_object_list.dart';
import 'package:http/http.dart'as http;
import 'package:toast/toast.dart';

import '../app_style.dart';
class ClassStudentsBehaviour extends StatefulWidget {
  final int tableCode;
  final String stageName;
  final String className;

  const ClassStudentsBehaviour({Key key, this.tableCode, this.stageName, this.className}) : super(key: key);
  @override
  _ClassStudentsBehaviourState createState() => _ClassStudentsBehaviourState();
}

class _ClassStudentsBehaviourState extends State<ClassStudentsBehaviour> {
  TextEditingController behave = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: FutureBuilder<List<StudentInList>>(
          future: TeacherClassStudentsInfo().getTeacherClassStudentInfo(widget.tableCode),
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
                            subtitle: Text('${snapshot.data[index].nameEN}',style: AppTextStyle.headerStyle2,maxLines: 2,),
                            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.text_snippet,color: ColorSet.SecondaryColor,)),
                          onTap: ()=>writeBehaviour(snapshot.data[index].schoolClassCode),
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
  writeBehaviour(int studentClassCode){
    var alert = AlertDialog(
      title: Center(child: Text("Student's behaviour",style: AppTextStyle.headerStyle2,)),
      content:Center(
        child:Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: behave,
                maxLines: 20,

                decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
              ),
            )
        )
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
          onPressed: () => postStudentCheckIn(studentClassCode, behave.text)
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
  postStudentCheckIn(int studentCode,var behaviour) async {
    var uri =  Uri.parse("http://169.239.39.105/lms_api2/swagger/ui/index#!/TeacherApi/TeacherApi_PostStudentClassRoomCheckIn");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['student_classRoom_checkin_code'] =studentCode.toString();
    request.fields['behaviour'] =behaviour;
    //request.fields['student_classRoom_checkIn_code'] ='1';
    //request.fields['behaviour'] ='test';


    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      Toast.show("Behaviour posted",context,duration:Toast.LENGTH_LONG);
      print("posted");
    }
    else{
      print("Not Posted");
    }

  }
}

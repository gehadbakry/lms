import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/teacher_api/getTeacherClassStudentList.dart';
import 'package:lms_pro/teacher_models/teacher_student_object_list.dart';
import 'package:http/http.dart'as http;
import 'package:toast/toast.dart';
class ClassStudentsList extends StatefulWidget {
  final int tableCode;
  final String stageName;
  final String className;

  const ClassStudentsList({Key key, this.tableCode,this.className,this.stageName}) : super(key: key);
  @override
  _ClassStudentsListState createState() => _ClassStudentsListState();
}

class _ClassStudentsListState extends State<ClassStudentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.check_circle,color: Colors.green,)),
                      onTap: ()=> postStudentCheckIn(snapshot.data[index].schoolClassCode),
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
  postStudentCheckIn(int studentCode) async {
    var uri =  Uri.parse("http://169.239.39.105/lms_api2/swagger/ui/index#!/TeacherApi/TeacherApi_PostStudentClassRoomCheckIn");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['student_classRoom_checkin_code'] =studentCode.toString();
    //request.fields['student_classRoom_checkIn_code'] ='1';
    request.fields['behaviour'] ='';


    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      Toast.show("Student is present",context,duration:Toast.LENGTH_LONG);
      print("posted");
    }
    else{
      print("Not Posted");
    }

  }
}

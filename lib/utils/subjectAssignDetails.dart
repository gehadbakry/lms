import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/assignment_info.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/Assignment.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_style.dart';
import 'package:toast/toast.dart';

class AssignmentDetails extends StatefulWidget {
  @override
  _AssignmentDetailsState createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  bool valuefirst = false;
  LoginResponseModel logInInfo;
  LoginRequestModel loginRequestModel;
  Subject subject;
  var code;
  var subjectCode;

  @override
  void initState() {
    loginRequestModel = LoginRequestModel();
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
    //AssignmentInfo().getAssignment(int.parse(code),subject.subjectCode );
    //print("from Assignme ${Provider.of<StudentData>(context ,listen: false).NameEn}");
    return Container(
      child: FutureBuilder<List<Assignment>>(
          future: AssignmentInfo().getAssignment(
              int.parse(code), subjectCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return GroupedListView<Assignment, int>(
                  elements: snapshot.data.toList(),
                  groupBy: (Assignment e) => e.assignmentCode,
                  groupHeaderBuilder: (Assignment e) =>  Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
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
                                child: LayoutBuilder(builder: (context, constraints) {
                                  return ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 5,right: 5 , left: 5),
                                      child: Row(
                                        children: [
                                          Text(e.assignmentName,
                                            style: AppTextStyle.headerStyle2,),
                                          Spacer(),
                                          Text("${(e.publishDate).substring(0,10)}", style: AppTextStyle.subText,),
                                        ],
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Center(
                                          ////WIDGET RETURNED ACCORDING TO TYPE EITHER ONLINE OR OFFLINE
                                          child: e.type == 1
                                              ? RaisedButton(
                                              child: Text("Show Assignment"),
                                              textColor: ColorSet.whiteColor,
                                              color: ColorSet.SecondaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    18.0),
                                              ),
                                              onPressed: () async{
                                                String url = "http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.filePath}";
                                                try{
                                                  await canLaunch(url)?await launch(url ):throw 'error';
                                                }
                                                catch(e){
                                                  Toast.show("Assignment not found ", context,
                                                    duration:Toast.LENGTH_LONG,);
                                                }
                                              })
                                              : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.file_download),
                                                iconSize: 35,
                                                color:  ColorSet.primaryColor,

                                              ),
                                              SizedBox(width: 10,),
                                              IconButton(
                                                icon: Icon(Icons.file_upload),
                                                iconSize: 35,
                                                color: ColorSet.SecondaryColor,
                                                disabledColor: ColorSet.primaryColor,
                                                  onPressed: () async{
                                                    String url = "http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.filePath}";
                                                    try{
                                                      await canLaunch(url)?await launch(url ):throw 'error';
                                                    }
                                                    catch(e){
                                                      Toast.show("Assignment not found ", context,
                                                        duration:Toast.LENGTH_LONG,);
                                                    }
                                                  }
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 5 ,right: 5,left: 5,bottom: 7),
                                                child: Row(
                                                  children: [
                                                    Text("Result : ${e.assignmentMark} / ${e.totalGrade}",
                                                      style: AppTextStyle.headerStyle2,),
                                                    Spacer(),
                                                    InkWell(child: Text("Show lessons",style: AppTextStyle.complaint,),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  );
                                },
                                ),
                              ),
                              onTap:  () => alertDialog(e.assignmentCode , e.assignmentName),
                            ),
                          ),
                  itemBuilder: (context, Assignment e){
                    return null;
                  },
                  order: GroupedListOrder.ASC,
                );
              }
              else {
                return Center(
                  child: Text(
                    "There is no Assignments", style: AppTextStyle.headerStyle2,),
                );
              }
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text("Error", style: AppTextStyle.headerStyle2,),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          })
    );
  }
  alertDialog(var newCode , String newName) {
    var alert = FutureBuilder<List<Assignment>>(
        future: AssignmentInfo().getAssignment(int.parse(code), subjectCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  AlertDialog(
              title: Column(
                children: [
                  Text(newName , style: AppTextStyle.headerStyle2,),
                  Center(child: Text("Lessons" , style: AppTextStyle.complaint,)),
                ],
              ),
              content: Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder:(context , index){
                      if(snapshot.data[index].assignmentCode == newCode){
                        return Center(child: Text('${snapshot.data[index].lessonNameAr}' , style: AppTextStyle.textstyle15,));
                      }
                      return Text("");
                    } ),
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
        }
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
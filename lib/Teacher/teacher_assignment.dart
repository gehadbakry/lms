import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherAssignments.dart';
import 'package:lms_pro/teacher_models/teacher_assignment_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

import '../app_style.dart';

class TeacherAssignments extends StatefulWidget {
  final stageSubjectCode;

  const TeacherAssignments({Key key, this.stageSubjectCode}) : super(key: key);
  @override
  _TeacherAssignmentsState createState() => _TeacherAssignmentsState();
}

class _TeacherAssignmentsState extends State<TeacherAssignments> {
  int code;
  int SchoolYear;
  int subjestStageCode;
  TextEditingController LinkName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      subjestStageCode = widget.stageSubjectCode;
    });
    return Scaffold(
        backgroundColor: ColorSet.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorSet.primaryColor,
          elevation: 0.0,
          title: Text(
            "Assignments",
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
            child: FutureBuilder<List<TeacherAssignment>>(
              future: TeacherAssignmentInfo().getTeacherAssignmentInfo(11, 169),
              //future: TeacherAssignmentInfo().getTeacherAssignmentInfo(code, subjestStageCode),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return GroupedListView<TeacherAssignment,int>(
                      elements: snapshot.data.toList(),
                      groupBy: (TeacherAssignment e) =>e.chapterCode==null?e.lessonCode:e.chapterCode,
                     groupHeaderBuilder: (TeacherAssignment e) {
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
                               child: Column(
                                 children: [
                                   ListTile(
                                       leading: Text(
                                         e.lessonNameEN==null?e.chapterNameAR:e.lessonNameEN,
                                         style: AppTextStyle.headerStyle2,
                                       ),
                                       trailing: Icon(
                                         Icons.arrow_forward_ios_outlined,
                                         color: ColorSet.primaryColor,
                                       ),
                                       onTap: ()=>lessonDialog((e.chapterCode==null?e.lessonCode:e.chapterCode),
                                           e.lessonNameEN==null?e.chapterNameAR:e.lessonNameEN)
                                   ),
                                   GestureDetector(
                                    //onTap: ()=>postAssignmentDialogfomLesson(e.lessonCode),
                                     onTap: ()=>postAssignmentDialog(e.chapterCode,e.lessonCode),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         IconButton(onPressed: () {}, icon:Icon(Icons.add,color: ColorSet.SecondaryColor,) ),
                                         Text("Add a new Assignment",style: AppTextStyle.subText,)
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       );
                     },
                      itemBuilder: (context, TeacherAssignment e) {
                    return null;
                  },
                order: GroupedListOrder.DESC,
                  );
                }
                else if(snapshot.hasError){
                  return Center(child: Text("error"),);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
           ));
  }

  lessonDialog(var assignmentCode , var assignmentName ){
    var alert = AlertDialog(
      title: Center(child: Text('${assignmentName}',style: AppTextStyle.complaint,),),
      content: FutureBuilder<List<TeacherAssignment>>(
        future: TeacherAssignmentInfo().getTeacherAssignmentInfo(11, 169),
        //future: TeacherAssignmentInfo().getTeacherAssignmentInfo(code, subjestStageCode),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return GroupedListView<TeacherAssignment,int>(
              elements: snapshot.data.toList(),
              groupBy: (TeacherAssignment e) => e.assignCode,
              groupHeaderBuilder: (TeacherAssignment e) {
                return Container(height: 0,width: 0,);
              },
              itemBuilder: (context, TeacherAssignment e) {
                return (e.lessonCode==assignmentCode||e.chapterCode==assignmentCode)?
                    Column(
                      children: [
                        Text(e.assignmentName,style: AppTextStyle.headerStyle2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: ()async{
                              String url = e.filePath;
                              e.type==2?
                              await canLaunch('http://169.239.39.105/LMS_site_demo/Home/Getpdf?path=${e.filePath}') ?
                              await launch('http://169.239.39.105/LMS_site_demo/Home/Getpdf?path=${e.filePath}') : throw 'error'
                                  :
                              Toast.show(
                                "No Material was found",
                                context,
                                duration: Toast.LENGTH_LONG,
                              );

                            }, icon: Icon(Icons.insert_drive_file,color:e.type==2?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                            IconButton(onPressed: ()async{
                              String url = e.filePath;
                              e.type==3?
                              await canLaunch(url) ? await launch(url) : throw 'error'
                                  :
                              Toast.show(
                                "No video was found",
                                context,
                                duration: Toast.LENGTH_LONG,
                              );
                            }, icon: Icon(Icons.link,color:e.type==3?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                            IconButton(onPressed: ()async{
                              String url = e.filePath;
                              e.type==1?
                              await canLaunch('http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.filePath}') ?
                              await launch('http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.filePath}') : throw 'error'
                                  :
                              Toast.show(
                                "No link was found",
                                context,
                                duration: Toast.LENGTH_LONG,
                              );
                            }, icon: Icon(Icons.image,color:e.type==1?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                          ],
                        ),
                        Container(
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: new BorderRadius.all(Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed: () => editAssignment(e.chapterCode,e.lessonCode,e.assignCode,
                                  e.assignmentName,e.totalGrade,e.filePath), icon:Icon(Icons.edit,color: ColorSet.primaryColor,) ),
                              IconButton(onPressed: () => deleteAssignment(e.assignCode), icon:Icon(Icons.delete,color: Colors.red,)),
                            ],
                          ),
                        ),
                      ],
                    )
                   :Container(height: 0,width: 0,);
              },
              order: GroupedListOrder.DESC,
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("error"),);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
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

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  postAssignmentDialog(var chapterCode,var lessonCode){
    File file;
    TextEditingController MaterialName = TextEditingController();
    TextEditingController grade = TextEditingController();
    var alert = AlertDialog(
      title: Center(child: Text('Add New assignment',style: AppTextStyle.headerStyle2,)),
      content:  ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: MaterialName,
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
                    hintText: "Assignment's name"

                ),

              ),
            ),
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: grade,
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
                    hintText: "Total Grade"

                ),

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: ColorSet.SecondaryColor,
                  ),
                  child: Text("file"),
                  onPressed: ()async{
                    file = await FilePicker.getFile();
                  },
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: ColorSet.SecondaryColor,
                  ),
                  child: Text("image"),
                  onPressed: ()async{
                    file = await FilePicker.getFile();
                  },
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: ColorSet.SecondaryColor,
                  ),
                  child: Text("link"),
                  onPressed: (){
                    addLink();
                  },
                ),
              ],
            ),
          ),

          ElevatedButton(onPressed: ()async{
            var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostAssignmentCreate");
            var request = new http.MultipartRequest("POST", uri);
            request.fields['publish_time'] = DateFormat('HH:MM:00').format(DateTime.now());
            request.fields['assignment_name'] =MaterialName.text;
            request.fields['publish_date'] =DateFormat('dd-MM-yyy').format(DateTime.now()) ;
            request.fields['total_grade'] = grade.text;
            request.fields['teacher_code'] = Provider.of<APIService>(context, listen: false).code.toString();
            //request.fields['stage_subject_code'] = (widget.stageSubjectCode).toString();
            request.fields['stage_subject_code'] = '169';
            request.fields['classes'] = '13';
            request.fields['chapters'] =chapterCode==null?"":chapterCode.toString();
            request.fields['lessons'] =lessonCode==null?'':lessonCode.toString();
            file == null?request.fields['file']= '':request.files.add(await http.MultipartFile.fromPath('file',file.path));


            request.headers.addAll({
            'Content-Type': 'multipart/form-data',
            });

            var response = await request.send();
            print(response.statusCode);
            if (response.statusCode == 200) {
            Toast.show("File was Posted",context,duration:Toast.LENGTH_LONG);
            print("posted");
            }
            else{
            print("Not Posted");
            }
          },
              child:  Text("Save and upload",),
            style: ElevatedButton.styleFrom(
                primary: ColorSet.primaryColor
            ),)
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
  editAssignment(var chapterCode,var lessonCode,var assignCode,var assignName , var totalGrade,var filePath){
    File file;
    TextEditingController MaterialName = TextEditingController();
    TextEditingController grade = TextEditingController();
    var alert = AlertDialog(
      title: Center(child: Text('Edit assignment name',style: AppTextStyle.headerStyle2,)),
      content:  ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: MaterialName,
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
                    hintText: "Assignment's name"

                ),

              ),
            ),
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              child: TextField(
                controller: grade,
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
                    hintText: "Edit total Grade"

                ),

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: ColorSet.SecondaryColor,
                  ),
                  child: Text("file"),
                  onPressed: ()async{
                    file = await FilePicker.getFile();
                  },
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: ColorSet.SecondaryColor,
                  ),
                  child: Text("image"),
                  onPressed: ()async{
                    file = await FilePicker.getFile();
                  },
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: ColorSet.SecondaryColor,
                  ),
                  child: Text("link"),
                  onPressed: (){
                    addLink();
                  },
                ),
              ],
            ),
          ),

          ElevatedButton(onPressed: ()async{
            print(MaterialName.text.isEmpty);
            print( MaterialName.text);
            print(assignName);
            print( grade.text.isEmpty);
            print(totalGrade);
            print(grade.text);
            print(file);
            print(filePath);
            print(Provider.of<APIService>(context, listen: false).code);
            print(DateFormat('HH:MM:00').format(DateTime.now()));
            print(DateFormat('dd-MM-yyy').format(DateTime.now()));
            print('chapter Code ${chapterCode}');
            print('lesson code ${lessonCode}');
            print('assignment code ${assignCode}');
            var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostAssignmentEdit");
            var request = new http.MultipartRequest("POST", uri);
            request.fields['publish_time'] = DateFormat('HH:MM:00').format(DateTime.now());
            request.fields['assignment_name'] =MaterialName.text.isEmpty?assignName:MaterialName.text;
            request.fields['publish_date'] =DateFormat('dd-MM-yyy').format(DateTime.now()) ;
            request.fields['total_grade'] = grade.text.isEmpty?totalGrade.toString():grade.text;
            //request.fields['teacher_code'] = Provider.of<APIService>(context, listen: false).code.toString();
            //request.fields['stage_subject_code'] = (widget.stageSubjectCode).toString();
            request.fields['teacher_code'] = '11';
            request.fields['stage_subject_code'] = '169';
            request.fields['classes'] = '13';
            request.fields['chapters'] =chapterCode==null?'':chapterCode.toString();
            request.fields['lessons'] =lessonCode==null?'':lessonCode.toString();
            file == null?request.fields['file']=filePath:request.files.add(await http.MultipartFile.fromPath('file',file.path));
            request.fields['assignment_code'] =assignCode.toString();

            request.headers.addAll({
              'Content-Type': 'multipart/form-data',
            });

            var response = await request.send();
            print(response.statusCode);
            if (response.statusCode == 200) {
              Toast.show("File was Posted",context,duration:Toast.LENGTH_LONG);
              print("posted");
            }
            else{
              print("Not Posted");
            }
          },
            child:  Text("Save and upload",),
            style: ElevatedButton.styleFrom(
                primary: ColorSet.primaryColor
            ),)
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
  deleteAssignment(var assignmentCode)async{
    var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostAssignmentDelete");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['assignment_code'] = assignmentCode.toString();

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      Toast.show("Material was deleted",context,duration:Toast.LENGTH_LONG);
      print("delete");
    }
    else{
      print("Not deleted");
    }
  }
  addLink(){
    var alert = AlertDialog(
      content:  Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
          child: TextField(
            controller:LinkName,
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
                hintText: "Enter your link"

            ),

          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "okay",
            style: TextStyle(color: ColorSet.SecondaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherMaterial.dart';
import 'package:lms_pro/teacher_models/teacher_material_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';

import '../app_style.dart';

class TeacherMaterials extends StatefulWidget {
  final stageSubjectCode;

  const TeacherMaterials({Key key, this.stageSubjectCode}) : super(key: key);

  @override
  _TeacherMaterialsState createState() => _TeacherMaterialsState();
}

class _TeacherMaterialsState extends State<TeacherMaterials> {
  int code;
  int SchoolYear;
  int subjestStageCode;
  var subjectChapterLessonCode;
  bool isPublished = false;

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
          "Material",
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
          child: FutureBuilder<List<TeacherMaterial>>(
              future: TeacherMaterialInfo().getTeacherMaterialInfo(code, SchoolYear, widget.stageSubjectCode),
             // future: TeacherMaterialInfo().getTeacherMaterialInfo(code, SchoolYear, 236),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.length==0?
                      Center(child: Text("No Chapters were found",style: AppTextStyle.headerStyle2,),)
                      :GroupedListView<TeacherMaterial, int>(
                    elements: snapshot.data.toList(),
                    groupBy: (TeacherMaterial e) => e.chapterCode,
                    groupHeaderBuilder: (TeacherMaterial e) {
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
                                  e.chapterNameEN,
                                  style: AppTextStyle.headerStyle2,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: ColorSet.primaryColor,
                                ),
                                onTap: () =>
                                    lessonDialog(e.chapterCode, e.chapterNameEN,e.chapterLessonCode),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemBuilder: (context, TeacherMaterial e) {
                      return null;
                    },
                    order: GroupedListOrder.ASC,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  lessonDialog(var ChapterCode, var ChapterName , var lessoncode) {
    var alert =lessoncode==null?AlertDialog(
      title: Text("No lessons to show",style: AppTextStyle.headerStyle2,),
    ): AlertDialog(
      title: Center(
          child: Text(
            ChapterName,
            style: AppTextStyle.headerStyle2,
          )),
      content: FutureBuilder<List<TeacherMaterial>>(
          //future: TeacherMaterialInfo().getTeacherMaterialInfo(code, SchoolYear, 236),
          future: TeacherMaterialInfo().getTeacherMaterialInfo(code, SchoolYear, subjestStageCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length==0?Center(child: Text("No lessons were found",style: AppTextStyle.headerStyle2,),)
                  : Container(
                child: GroupedListView<TeacherMaterial, int>(
                  elements: snapshot.data.toList(),
                  groupBy: (TeacherMaterial e) =>e.chapterLessonCode==null?-1:e.chapterLessonCode,
                  groupHeaderBuilder: (TeacherMaterial e) {
                 return  e.chapterCode==ChapterCode? Padding(
                      padding: EdgeInsets.only(top: 10 , left:10 ,right:10 ,bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: ColorSet.whiteColor,
                          boxShadow: [ BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(4, 2), // changes position of shadow
                          ),],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(e.lessonNameEn,style: AppTextStyle.subtextgrey,),
                              trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey,),
                              onTap: () => chooseMaterial(e.lessonNameAR , e.chapterLessonCode ,ChapterCode,e.materialType),
                            ),
                            GestureDetector(
                              onTap: () => uploadMaterialDialog(e.chapterLessonCode),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(onPressed: () {}, icon:Icon(Icons.add,color: ColorSet.SecondaryColor,) ),
                                 Text("Add a new Material",style: AppTextStyle.subText,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ):
                    Container(height: 0,width: 0,);
                  },
                  itemBuilder: (context, TeacherMaterial e) =>null,
                  order: GroupedListOrder.ASC,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
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
  chooseMaterial(var lessonName,var lessonCode,var ChapterCode,var materialType){
    var alert = materialType==null?AlertDialog(title: Text("No material to show",style: AppTextStyle.headerStyle2,),):AlertDialog(
      title: Center(child: Text(lessonName,style: AppTextStyle.complaint,)),
      content:  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.grey.shade50,
        ),
        child: FutureBuilder<List<TeacherMaterial>>(
            //future: TeacherMaterialInfo().getTeacherMaterialInfo(code, SchoolYear, 236),
            future: TeacherMaterialInfo().getTeacherMaterialInfo(code, SchoolYear, widget.stageSubjectCode),
            builder: (context , snapshot){
              if(snapshot.hasData){
                return Center(
                  child: snapshot.data.length==0?Text("No Material was found",style: AppTextStyle.headerStyle2,):GroupedListView<TeacherMaterial, int>(
                    elements: snapshot.data.toList(),
                    groupBy: (TeacherMaterial e) =>e.chapterLessonMaterialCode==null?-1:e.chapterLessonMaterialCode,
                    groupHeaderBuilder: (TeacherMaterial e) => e.chapterCode==ChapterCode && e.chapterLessonCode == lessonCode?
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          Text(e.materialName,style: AppTextStyle.textstyle15,),
                          e.materialType==null?Container(child:Text('No material to show')): Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(onPressed: ()async{
                                    String url = e.materialpath;
                                    e.materialType==2?
                                    await canLaunch(url) ? await launch(url) : throw 'error'
                                        :
                                    Toast.show(
                                      "No Material was found",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                    );

                                  }, icon: Icon(Icons.insert_drive_file,color:e.materialType==2?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                                  IconButton(onPressed: ()async{
                                    String url = e.materialpath;
                                    e.materialType==3?
                                    await canLaunch(url) ? await launch(url) : throw 'error'
                                        :
                                    Toast.show(
                                      "No video was found",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                    );
                                  }, icon: Icon(Icons.video_call,color:e.materialType==3?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                                  IconButton(onPressed: ()async{
                                    String url = e.materialpath;
                                    e.materialType==1?
                                    await canLaunch(url) ? await launch(url) : throw 'error'
                                        :
                                    Toast.show(
                                      "No link was found",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                    );
                                  }, icon: Icon(Icons.link,color:e.materialType==1?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                                ],
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: ColorSet.whiteColor,
                                  borderRadius: new BorderRadius.all(Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(onPressed: () => editMaterialDialog(e.chapterLessonCode,e.chapterLessonMaterialCode), icon:Icon(Icons.edit,color: ColorSet.primaryColor,) ),
                                    IconButton(onPressed: () => deleteMaterialDialog(e.chapterLessonMaterialCode), icon:Icon(Icons.delete,color: Colors.red,)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ):Container(height: 0.0,width: 0.0,),
                    itemBuilder: (context, TeacherMaterial e) =>null,
                    order: GroupedListOrder.ASC,
                  ),
                );
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text("Error"),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        ),
      ) ,
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

    uploadMaterialDialog(var chapterLessonCode){
    var extension ;
    File file;
    TextEditingController MaterialName = TextEditingController();
    bool isPressed = false;
    var alert = SafeArea(child:AlertDialog(
      title: Center(child: Text("Upload a new chapter",style: AppTextStyle.headerStyle2,),),
      content: Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: ListView(
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
                      hintText: "Material's name"

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
                    extension = "2";
                    },
                  ),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: ColorSet.SecondaryColor,
                    ),
                    child: Text("image"),
                    onPressed: ()async{
                        file = await FilePicker.getFile();
                        extension = "1";
                    },
                  ),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: ColorSet.SecondaryColor,
                    ),
                    child: Text("link"),
                    onPressed: ()async{
                        file = await FilePicker.getFile();
                        extension = "3";
                    },
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Checkbox(
                  value: isPublished,
                      activeColor: ColorSet.SecondaryColor,
                      onChanged: (bool newValue){
                        setState(() {
                          this.isPublished = newValue  ;
                          isPressed = !isPressed;
                        });
                        print(isPublished);
                        print(isPressed);
                      }),
                 // isPressed==true?Icon(Icons.check,color: Colors.red,):Container(height: 0,width: 0,),

              title: Text("Delay publishing?",style: AppTextStyle.headerStyle2,),
            ),

            ElevatedButton(
              onPressed: ()async{
                var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostMaterialUpload");
                var request = new http.MultipartRequest("POST", uri);
                request.fields['material_name'] = MaterialName.text;
                //request.fields['file']= code.toString();
                //request.files.add(await http.MultipartFile.fromPath('file',file.path));
                file == null?request.fields['file']= '':request.files.add(await http.MultipartFile.fromPath('file',file.path));
                request.fields['material_type_code'] = extension;
                request.fields['subject_chapter_lesson_code'] = chapterLessonCode.toString();
                request.fields['schooling_year_code'] = SchoolYear.toString();
                request.fields['publish_date'] =  DateFormat('dd-MM-yyy').format(DateTime.now());
                request.fields['is_publish'] = isPublished==true?"False":"True";
                request.fields['user_update_code'] = Provider.of<APIService>(context, listen: false).usercode;
                request.fields['classes'] = '10';
                request.fields['stage_subject_code'] = (widget.stageSubjectCode).toString();
                request.fields['material_path'] ='';


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
              child: Text("Save and upload",),
              style: ElevatedButton.styleFrom(
                  primary: ColorSet.primaryColor
              ),
            ),

          ],
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
    ) );

    showDialog(context: context, builder: (BuildContext context) => alert);
   }
    editMaterialDialog(var chapterLessonCode,var chapterLessonMaterialCode){
     var extension ;
     File file;
     bool isPressed = false;
     TextEditingController EditMaterialName = TextEditingController();
     var alert = AlertDialog(
       title: Center(child: Text("Edit Materials",style: AppTextStyle.headerStyle2,)),
       content: ListView(
         children: [
           Container(
             child: Padding(
               padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
               child: TextField(
                 controller:EditMaterialName,
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
                     hintText: "Material's new name"

                 ),

               ),
             ),
           ),

           Padding(
             padding: const EdgeInsets.only(top: 10,bottom: 10),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     ElevatedButton(
                       style:ElevatedButton.styleFrom(
                         primary: ColorSet.SecondaryColor,
                       ),
                       child: Text("New file"),
                       onPressed: ()async{
                         file = await FilePicker.getFile();
                         extension = "2";
                       },
                     ),
                     ElevatedButton(
                       style:ElevatedButton.styleFrom(
                         primary: ColorSet.SecondaryColor,
                       ),
                       child: Text("New image"),
                       onPressed: ()async{
                         file = await FilePicker.getFile();
                         extension = "1";
                       },
                     ),
                   ],
                 ),
                 ElevatedButton(
                   style:ElevatedButton.styleFrom(
                     primary: ColorSet.SecondaryColor,
                   ),
                   child: Text("New link"),
                   onPressed: ()async{
                     file = await FilePicker.getFile();
                     extension = "3";
                   },
                 ),
               ],
             ),
           ),

           ListTile(
             leading: Checkbox(
                 value: isPublished,
                 activeColor: ColorSet.SecondaryColor,
                 onChanged: (bool newValue){
                   setState(() {
                     this.isPublished = newValue  ;
                     isPressed = !isPressed;
                   });
                   print(isPublished);
                   print(isPressed);
                 }),
             // isPressed==true?Icon(Icons.check,color: Colors.red,):Container(height: 0,width: 0,),

             title: Text("Delay publishing?",style: AppTextStyle.headerStyle2,),
           ),

           ElevatedButton(
             onPressed: ()async{
               var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostMaterialEdit");
               var request = new http.MultipartRequest("POST", uri);
               request.fields['material_name'] = EditMaterialName.text;
               //request.fields['file']= code.toString();
               //request.files.add(await http.MultipartFile.fromPath('file',file.path));
               file == null?request.fields['file']= '':request.files.add(await http.MultipartFile.fromPath('file',file.path));
               request.fields['material_type_code'] = extension==null?'':extension;
               request.fields['subject_chapter_lesson_code'] = chapterLessonCode.toString();
               request.fields['schooling_year_code'] = SchoolYear.toString();
               request.fields['publish_date'] =  DateFormat('dd-MM-yyy').format(DateTime.now());
               request.fields['is_publish'] = isPublished==true?"False":"True";
               request.fields['user_update_code'] = Provider.of<APIService>(context, listen: false).usercode;
               request.fields['classes'] = '';
               request.fields['stage_subject_code'] = '236';
               request.fields['material_path'] ='';
               request.fields['subjects_chapters_lessons_material_code']= chapterLessonMaterialCode.toString();


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
             child: Text("Save and upload",),
             style: ElevatedButton.styleFrom(
                 primary: ColorSet.primaryColor
             ),
           ),
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
    )
     );
     showDialog(context: context, builder: (BuildContext context) => alert);
   }
    deleteMaterialDialog(var chapterMaterialCode)async{
     var uri =  Uri.parse("http://169.239.39.105/lms_api2/api/TeacherApi/PostMaterialDelete");
     var request = new http.MultipartRequest("POST", uri);
     request.fields['subjects_chapters_lessons_material_code'] = chapterMaterialCode.toString();

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


}
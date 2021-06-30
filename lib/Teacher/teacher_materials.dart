import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherMaterial.dart';
import 'package:lms_pro/teacher_models/teacher_material_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
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

  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      subjestStageCode = widget.stageSubjectCode;
    });
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      floatingActionButton: Container(
        width:155,
        child: FloatingActionButton(
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(45.0))
          ),
          backgroundColor: ColorSet.SecondaryColor,
          child:Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add , color:ColorSet.whiteColor),
                Text("Add chapter",style:TextStyle(fontSize: 14,color: ColorSet.whiteColor))
              ],
            ),
          ),
          onPressed: (){},
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
        title: Text(
          "Material",
          style: AppTextStyle.headerStyle,
        ),
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
          padding: const EdgeInsets.only(top: 10,bottom: 65),
          child: FutureBuilder<List<TeacherMaterial>>(
              future: TeacherMaterialInfo()
                  .getTeacherMaterialInfo(code, SchoolYear, 236),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GroupedListView<TeacherMaterial, int>(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (){}, icon:Icon(Icons.add,color: ColorSet.SecondaryColor,) ),
                              IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: ColorSet.primaryColor,) ),
                              IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.red,)),
                            ],
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
          future: TeacherMaterialInfo()
              .getTeacherMaterialInfo(code, SchoolYear, 236),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  Container(
                child: GroupedListView<TeacherMaterial, int>(
                  elements: snapshot.data.toList(),
                  groupBy: (TeacherMaterial e) =>e.chapterLessonCode==null?-1:e.chapterLessonCode,
                    groupHeaderBuilder: (TeacherMaterial e) => e.chapterCode==ChapterCode? Padding(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(onPressed: (){}, icon:Icon(Icons.add,color: ColorSet.SecondaryColor,) ),
                                IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: ColorSet.primaryColor,) ),
                                IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.red,)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ):
                    Container(height: 0,width: 0,),
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
            future: TeacherMaterialInfo()
                .getTeacherMaterialInfo(code, SchoolYear, 236),
            builder: (context , snapshot){
              if(snapshot.hasData){
                return Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Center(
                    child: GroupedListView<TeacherMaterial, int>(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: ColorSet.SecondaryColor,) ),
                                    IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.red,)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ):Container(height: 0.0,width: 0.0,),
                      itemBuilder: (context, TeacherMaterial e) =>null,
                      order: GroupedListOrder.ASC,
                    ),
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
}

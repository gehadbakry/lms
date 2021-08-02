import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/material_info.dart';
import 'package:lms_pro/models/material_data.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_style.dart';
import '../main.dart';
import '../testpage.dart';

class BuildMaterialPage extends StatefulWidget {
  @override
  _BuildMaterialPageState createState() => _BuildMaterialPageState();
}

class _BuildMaterialPageState extends State<BuildMaterialPage> {
  int currentPage = 0;
  Subject subject;
  static var subjectCode;
  static var code;
  var usercode;
  var args;
  Color iconColor = ColorSet.inactiveColor;
  void initState() {
    subject = Subject();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    // setState(() {
    //   code = Provider.of<APIService>(context, listen: false).code;
    //   subjectCode = subject.subjectCode;
    // });
    setState(() {
      if (Provider.of<APIService>(context, listen: false).usertype == "2"){
        code = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
        subjectCode = args[0].subjectCode;
      }
      else if(Provider.of<APIService>(context, listen: false).usertype == "3" ||Provider.of<APIService>(context, listen: false).usertype == "4" ){
        code = (args[1].studentCode).toString();
        usercode = (args[1].userCode).toString();
        subjectCode = args[0].subjectCode;
      }
    }
    );
    return FutureBuilder<List<Materials>>(
        future: MaterialInfo().getMaterial(int.parse(code), subjectCode),
        builder: (context , snapshot){
          if(snapshot.hasData){
           return snapshot.data.length==0?
           Center(child: Text("No Material was found",style: AppTextStyle.headerStyle2,)):
           Padding(
             padding: const EdgeInsets.only(top: 10),
             child: GroupedListView<Materials, int>(
                 elements: snapshot.data.toList(),
                 groupBy: (Materials e) => e.subjectChapterCode,
                 groupHeaderBuilder: (Materials e) {
                   return Padding(
                     padding: const EdgeInsets.only(right: 20 , left :20 , top: 7 , bottom: 10),
                     child: Container(
                       width: MediaQuery.of(context).size.width*0.8,
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
                       child: ListTile(
                         leading: Text(e.chapterNameAr,style: AppTextStyle.headerStyle2,),
                         trailing: Icon(Icons.arrow_forward_ios_outlined,color: ColorSet.primaryColor,),
                         onTap: () => lessonDialog(e.subjectChapterCode,e.chapterNameAr),
                       ),
                     ),
                   );
                 },
               itemBuilder: (context, Materials e){
                 return null;
               },
               order: GroupedListOrder.ASC,
             ),
           );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
  lessonDialog(var ChapterCode , var ChapterName){
    var alert = AlertDialog(
      title: Center(child: Text(ChapterName,style: AppTextStyle.headerStyle2,)),
      content:  FutureBuilder<List<Materials>>(
    future: MaterialInfo().getMaterial(int.parse(code), subjectCode),
    builder: (context , snapshot){
      if(snapshot.hasData){
        return Container(
          height: MediaQuery.of(context).size.height*0.4,
          child: Center(
            child: GroupedListView<Materials, int>(
              elements: snapshot.data.toList(),
              groupBy: (Materials e) =>e.subjectChapterLessonCode ,
              groupHeaderBuilder: (Materials e) => e.subjectChapterCode==ChapterCode?
              Padding(
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
                  child: ListTile(
                    leading: Text(e.lessonNameAr,style: AppTextStyle.subtextgrey,),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey,),
                    onTap: () => chooseMaterial(e.lessonNameAr , e.subjectChapterLessonCode ,ChapterCode),
                  ),
                ),
              ):Container(height: 0.0,width: 0.0,),
              itemBuilder: (context, Materials e) =>null,
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
      ) ,
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

  chooseMaterial(var lessonName,var lessonCode,var ChapterCode){
    var alert = AlertDialog(
      title: Center(child: Text(lessonName,style: AppTextStyle.complaint,)),
      content:  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.grey.shade50,
        ),
        child: FutureBuilder<List<Materials>>(
            future: MaterialInfo().getMaterial(int.parse(code), subjectCode),
            builder: (context , snapshot){
              if(snapshot.hasData){
                return Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Center(
                    child: GroupedListView<Materials, int>(
                      elements: snapshot.data.toList(),
                      groupBy: (Materials e) =>e.subjectChapterLessonMaterialCode ,
                      groupHeaderBuilder: (Materials e) => e.subjectChapterCode==ChapterCode && e.subjectChapterLessonCode == lessonCode?
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Text(e.materialName,style: AppTextStyle.textstyle15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(onPressed: ()async{
                                  String url = e.materialPath;
                                  e.materilCode==2?
                                    await canLaunch(url) ? await launch(url) : throw 'error'
                                  :
                                  Toast.show(
                                  "No Material was found",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  );

                                }, icon: Icon(Icons.insert_drive_file,color:e.materilCode==2?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                                IconButton(onPressed: ()async{
                                  String url = e.materialPath;
                                  e.materilCode==3?
                                  await canLaunch(url) ? await launch(url) : throw 'error'
                                      :
                                  Toast.show(
                                  "No video was found",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  );
                                }, icon: Icon(Icons.video_call,color:e.materilCode==3?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                                IconButton(onPressed: ()async{
                                  String url = e.materialPath;
                                  e.materilCode==1?
                                  await canLaunch(url) ? await launch(url) : throw 'error'
                                      :
                                  Toast.show(
                                  "No link was found",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  );
                                }, icon: Icon(Icons.link,color:e.materilCode==1?ColorSet.primaryColor:ColorSet.inactiveColor,)),
                              ],
                            ),
                          ],
                        ),
                      ):Container(height: 0.0,width: 0.0,),
                      itemBuilder: (context, Materials e) =>null,
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


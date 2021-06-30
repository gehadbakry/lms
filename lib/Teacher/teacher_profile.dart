import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/Teacher/teacher_bottomAppBar.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherProfile.dart';
import 'package:lms_pro/teacher_api/getTeacherSubjects.dart';
import 'package:lms_pro/teacher_models/teacher_profile_model.dart';
import 'package:lms_pro/teacher_models/teacher_subjects.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';

class TeacherProfile extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) {
    int code = int.parse(Provider.of<APIService>(context, listen: false).code);
    int SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ////PICTURE CONTAINER
          Container(
            height: 120,
            child: Stack(
              children: [
                Container(
                  ////THE GREEN BACKGROUND BEHIND THE PHOTO
                  height: 90,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorSet.primaryColor,
                      borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(180.0),
                        bottomRight: const Radius.circular(180.0),
                      ),
                    ),
                  ),
                ),
                FutureBuilder<List<TeacherModel>>(
                    future: TeacherProfileInfo().getTeacherProfileInfo(code),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ////GROUP THE INFO FROM THE API USING TEACHER NAME AND USE THE PICTURE
                        return GroupedListView<TeacherModel, String>(
                          elements: snapshot.data.toList(),
                          groupBy: (TeacherModel e) => e.NameEN,
                          groupHeaderBuilder: (TeacherModel e) => Column(
                            children: [
                              Container(
                                height: 120,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 80,
                                      color: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorSet.primaryColor,
                                          borderRadius: new BorderRadius.only(
                                            bottomLeft:
                                            const Radius.circular(180.0),
                                            bottomRight:
                                            const Radius.circular(180.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: FittedBox(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                'http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.image}'),
                                            // backgroundImage: HttpStatus.internalServerError == 500
                                            //     ?AssetImage('assets/images/student.png')
                                            //     : NetworkImage(
                                            //     'http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.image}')
                                            // ,
                                            radius: 40.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          itemBuilder: (context, TeacherModel e) {
                            return null;
                          },
                          order: GroupedListOrder.ASC,
                        );
                      } else if (snapshot.hasError) {
                        return Text("error");
                      }
                      return CircularProgressIndicator();
                    }),
              ],
            ),
          ),
          /////INFO CARD CONTAINER
          Expanded(
            ////A TEACHER CAN BE TEACHING MORE THAN ONE CLASS SO WE SHOW THEM ALL
            child: FutureBuilder<List<TeacherModel>>(
                future: TeacherProfileInfo().getTeacherProfileInfo(code),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Padding(
                            ////TEACHER'S NAME
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Center(
                                child: Text('${snapshot.data[0].NameEN}',
                                    style: AppTextStyle.headerStyle2)),
                          ),
                          Expanded(
                            child: GroupedListView<TeacherModel, String>(
                              scrollDirection: Axis.horizontal,
                              elements: snapshot.data.toList(),
                              groupBy: (TeacherModel e) => e.NameEN,
                              groupHeaderBuilder: (TeacherModel e) => Container(height:0,width: 0,),
                              itemBuilder: (context, TeacherModel e) {
                                /////THE CONTAINER THAT CONTAINS THE STAGE AND CLASS THE TEACHER TEACHES
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 5 , left:5, ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorSet.whiteColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorSet.shadowcolour,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(4, 3),
                                          ),
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Stage: ',
                                                style: AppTextStyle.headerStyle2,
                                              ),
                                              Text(
                                                '${e.StageNameEn}',
                                                style: AppTextStyle.textstyle15,
                                              ),
                                            ],
                                          ),
                                          e.classNameEn==''?Container(height: 0,width: 0,):Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text('Class: ',
                                                  style: AppTextStyle.headerStyle2),
                                              Text('${e.classNameEn}',
                                                  style: AppTextStyle.textstyle15),
                                            ],
                                          ),
                                          e.classNameEn==''?Text(
                                            '${e.SubjectNameEN}',
                                            style: AppTextStyle.subText,
                                          ):Text(
                                            '${e.specialistEN}',
                                            style: AppTextStyle.subText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              order: GroupedListOrder.ASC,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("error");
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10,bottom: 10),
            child: Container(
              child:Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.3,
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 10),
                      child: Text("Your Courses",style: AppTextStyle.complaint,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.3,
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                )
              )
            ),
          ),
          ////SUBJECTS TEACHER TEACHES THIS YEAR
          Expanded(
            child: FutureBuilder<List<TeacherSubjects>>(
              future: TeacherSubjectsInfo().getTeacherSubjectsInfo(code, SchoolYear),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: (MediaQuery.of(context).size.width)*0.4,
                        childAspectRatio: 0.6,
                        crossAxisSpacing:5,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        return  GestureDetector(
                          child: Column(
                            children: [
                              Container(
                                width: 90,
                                height: 105,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorSet.shadowcolour,
                                        blurRadius: 7,
                                        offset: Offset(5,3),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage("http://169.239.39.105/LMS_site_demo/Home/GetImg?path=F:/docs${snapshot.data[index].image}"),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ),
                              Container(
                                width: 120,
                                child: ListTile(
                                  title: Text(snapshot.data[index].subjectNameEn , style:TextStyle(
                                      color: ColorSet.primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),maxLines: 3,),
                                  subtitle: snapshot.data[index].StageNameEn == null?Text(""):
                                  Text(snapshot.data[index].StageNameEn, style: TextStyle(
                                    color: ColorSet.inactiveColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                    maxLines: 2,
                                  ),

                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                TeacherBottomAppBar(stageSubjectCode: snapshot.data[index].subjectCode,)),);
                          },
                        );
                      }
                  );
                } else if (snapshot.hasError) {
                  return Text("error");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
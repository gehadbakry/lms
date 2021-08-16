import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lms_pro/Chat/ChatButton.dart';
import 'package:lms_pro/Teacher/teacher_bottomAppBar.dart';
import 'package:lms_pro/Teacher/teacher_checkIn.dart';
import 'package:lms_pro/Teacher/teacher_drawer.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherDays.dart';
import 'package:lms_pro/teacher_api/getTeacherProfile.dart';
import 'package:lms_pro/teacher_api/getTeacherScheduel.dart';
import 'package:lms_pro/teacher_api/getTeacherSubjects.dart';
import 'package:lms_pro/teacher_models/teacher_days.dart';
import 'package:lms_pro/teacher_models/teacher_profile_model.dart';
import 'package:lms_pro/teacher_models/teacher_scheduel.dart';
import 'package:lms_pro/teacher_models/teacher_subjects.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_style.dart';

class TeacherProfile extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  int code;
  int SchoolYear;
  int userCode;
  int scheduelDayCode;
  String DayNameAR;
  String DayNameEN;

  getDayNameAndCode() async {
    List<TeacherDays> DaysList = await TeacherDaysInfo().getTeacherDaysInfo(30, 17);
    //List<TeacherDays> DaysList = await TeacherDaysInfo().getTeacherDaysInfo(int.parse(Provider.of<APIService>(context, listen: false).code),
    // Provider.of<APIService>(context, listen: false).schoolYear);
    for (TeacherDays dayObject in DaysList) {
      if(dayObject.dayNameEN == DateFormat('EEEE').format(DateTime.now())){
        setState(() {
          DayNameAR = dayObject.dayNameAR;
          DayNameEN = dayObject.dayNameEN;
          scheduelDayCode = dayObject.dayCode;
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    getDayNameAndCode();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      userCode = int.parse(Provider.of<APIService>(context, listen: false).usercode);
    });
    return Scaffold(
      drawer: TeacherDrawer(),
      floatingActionButton: ChatButton(code: code,userCode: userCode,),
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          ////PICTURE CONTAINER
          Container(
            height: 150,
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
                                      height: 60,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: ColorSet.primaryColor,
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
                              Padding(
                                ////TEACHER'S NAME
                                padding: const EdgeInsets.only(top: 7, bottom: 10),
                                child: Center(
                                    child: Text('${snapshot.data[0].NameEN}',
                                        style: AppTextStyle.headerStyle2)),
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
          ////DAYS SEPARATOR
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                child:Center(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.1,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,left: 10),
                          child: Column(
                            children: [
                              Text("${DateFormat('EEEE').format(DateTime.now())}",style: AppTextStyle.subtextgrey,),
                              Text("${DateFormat('dd-MM-yyyy').format(DateTime.now())}",style: TextStyle(fontSize: 15,
                                  color: ColorSet.SecondaryColor),)
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.5,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    )
                )
            ),
          ),
          ////SCHEDUEL CONTAINER
          Container(
            height: 130,
            child: FutureBuilder<List<TeacherScheduel>>(
              //future: TeacherScheduelInfo().getTeacherScheduelInfo(30, 17, 2),
              future: TeacherScheduelInfo().getTeacherScheduelInfo(userCode, SchoolYear, scheduelDayCode),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        return
                          snapshot.data[index].dayCode == scheduelDayCode?
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: TimelineTile(
                            indicatorStyle: IndicatorStyle(
                              color: ColorSet.primaryColor,
                              indicatorXY: 0.4,
                              drawGap: true,
                            ),
                            endChild: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(snapshot.data[index].subjectNameEN , style: AppTextStyle.headerStyle2,),
                                      SizedBox(width: 15,),
                                      Text("${(snapshot.data[index].courseStart).substring(0,5)} : ${(snapshot.data[index].courseEnd).substring(0,5)}",style: AppTextStyle.subText,),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text('${snapshot.data[index].stageNameEn} ', style: AppTextStyle.subtextgrey,),
                                      Text('${snapshot.data[index].classNameEN}', style: AppTextStyle.subtextgrey,),
                                    ],
                                  ),
                                  trailing:Column(
                                    children: [
                                      Icon(Icons.arrow_forward_ios_outlined,color: Colors.red,),
                                    ],
                                  ),
                               onTap: () => checkIntoClassDialog(context,snapshot.data[index].schoolCourseCode,scheduelDayCode,
                                   (snapshot.data[index].courseStart).substring(0,5),(snapshot.data[index].courseEnd).substring(0,5),
                                 snapshot.data[index].classNameEN,snapshot.data[index].stageNameEn,snapshot.data[index].subjectNameEN
                               ),
                                ),
                              ],
                            ),
                            isFirst: index == 0  ? true : false,
                            isLast: index == snapshot.data.length-1 ? true : false,
                          ),
                        ) :
                        Center(
                          child: Text("No schedule today"),
                        );
                      });
                }
                else if(snapshot.hasError){
                  return Text("");
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
          ////COURSES SEPARATOR
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
                child:Center(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.2,
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
                              0.2,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    )
                )
            ),
          ),
          ////COURSES CONTAINER
          Container(
            height: 300,
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
                                width: MediaQuery.of(context).size.width*0.25,
                                height: MediaQuery.of(context).size.height*0.18,
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
                                TeacherBottomAppBar(stageSubjectCode: snapshot.data[index].stageSubjectCode,)),);
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
           ),
        ],
      ),
    );
  }
  checkIntoClassDialog(BuildContext context,int classCode,int dayCode,String start,String end,String className,String stageName,String subjectName){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CheckIn(dayCode: dayCode,courseCode: classCode,startTime: start,endTime: end,className: className,stageName: stageName,subjectName: subjectName,);
      },
    );
  }
  }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/Teacher/teacher_classes.dart';
import 'package:lms_pro/Teacher/teacher_edit_profile.dart';
import 'package:lms_pro/Teacher/teacher_events.dart';
import 'package:lms_pro/Teacher/teacher_journey.dart';
import 'package:lms_pro/Teacher/teacher_singleDay_scheduel.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherDays.dart';
import 'package:lms_pro/teacher_api/getTeacherProfile.dart';
import 'package:lms_pro/teacher_models/teacher_days.dart';
import 'package:lms_pro/teacher_models/teacher_profile_model.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import '../testpage.dart';

class TeacherDrawer extends StatefulWidget {
  final stageSubjectCode;

  const TeacherDrawer({Key key, this.stageSubjectCode}) : super(key: key);
  @override
  _TeacherDrawerState createState() => _TeacherDrawerState();
}

class _TeacherDrawerState extends State<TeacherDrawer> {
  int code;
  int SchoolYear;
  int userCode;
  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      userCode = int.parse(Provider.of<APIService>(context, listen: false).usercode);
    });
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 210,
            child: FutureBuilder<List<TeacherModel>>(
                future: TeacherProfileInfo().getTeacherProfileInfo(code),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ////GROUP THE INFO FROM THE API USING TEACHER NAME AND USE THE PICTURE
                    return GroupedListView<TeacherModel, String>(
                      elements: snapshot.data.toList(),
                      groupBy: (TeacherModel e) => e.NameEN,
                      groupHeaderBuilder: (TeacherModel e) => Padding(
                        padding: const EdgeInsets.only(top:30),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.image}'),
                              // backgroundImage: HttpStatus.internalServerError == 500
                              //     ?AssetImage('assets/images/student.png')
                              //     : NetworkImage(
                              //     'http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${e.image}')
                              // ,
                              radius: 44.0,
                            ),

                            Padding(
                          padding: const EdgeInsets.only(top: 15,bottom: 7),
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('${e.NameEN}', style: AppTextStyle.headerStyle2)),
                        ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('${e.specialistEN}', style: AppTextStyle.subText)),
                            ),
                          ],
                        ),
                      ),
                      itemBuilder: (context, TeacherModel e) {
                        return null;
                      },
                      order: GroupedListOrder.ASC,
                    );
                  } else if (snapshot.hasError) {
                    return Text("error");
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width *
                0.65,
            child: Divider(
              thickness: 1,
            ),
          ),
          ListTile(
            leading: Icon(Icons.celebration,color: ColorSet.primaryColor,),
            title: Text("Journeys",style: AppTextStyle.headerStyle2,),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  TeacherJourneys(stageSubjectCode: widget.stageSubjectCode,))
               );
            }
          ),
          ListTile(
            leading: Icon(Icons.event,color: ColorSet.primaryColor),
            title: Text("Events",style: AppTextStyle.headerStyle2,),
            onTap: ( ){Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  TeacherEvents())
           );}
          ),
          ListTile(
              leading: Icon(Icons.edit,color: ColorSet.primaryColor),
              title: Text("Edit profile",style: AppTextStyle.headerStyle2,),
              onTap: ( ){Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  TeacherEditProfile(code: code,usercode: userCode,))
              );}
          ),
          ListTile(
              leading: Icon(Icons.sensor_door_rounded,color: ColorSet.primaryColor),
              title: Text("My classes",style: AppTextStyle.headerStyle2,),
              onTap: ( ){Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeacherClasses(code: code,))
              );}
          ),
          ListTile(
              leading: Icon(Icons.schedule,color: ColorSet.primaryColor),
              title: Text("My schedule",style: AppTextStyle.headerStyle2,),
              onTap: ( ) => scheduelDialog(),
          ),
          Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: InkWell(
                child: Text("Log out?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: ColorSet.SecondaryColor),),
              ),
            ),
          )
        ],
      ),
    );
  }

  scheduelDialog(){
    var alert = AlertDialog(
      content: FutureBuilder< List<TeacherDays>>(
        future: TeacherDaysInfo().getTeacherDaysInfo(30, 17),
        //future:TeacherDaysInfo().getTeacherDaysInfo(code, SchoolYear );
        builder: (contex,snapshot){
          if(snapshot.hasData){
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
                  crossAxisSpacing:2,
                  crossAxisCount: 2,
                ),
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
                  return Center(
                    child: InkWell(
                      child: Text('${snapshot.data[index].dayNameEN}',style: AppTextStyle.headerStyle2,),
                      onTap: (){Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  SingleDayScheduel(dayCode: snapshot.data[index].dayCode,
                          dayNameAR: snapshot.data[index].dayNameAR,
                            dayNameEn:snapshot.data[index].dayNameEN ,
                          ))
                      );},
                    ),
                  );
    }
            );
          }
          else if(snapshot.hasError){
            return Text("error");
          }
          return Center(child: CircularProgressIndicator(),);
        },
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/NotifiCountAll.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/day_scheduel_info.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/day_scheduel.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_style.dart';
class ScheduelPage extends StatefulWidget {
  final int dayCode;
  final Scode;
  final userCode;
  final DayNameAR;
  final DayNameEn;

  const ScheduelPage({Key key, this.dayCode,this.userCode,this.Scode,this.DayNameAR,this.DayNameEn}) : super(key: key);
  @override
  _ScheduelPageState createState() => _ScheduelPageState();
}

class _ScheduelPageState extends State<ScheduelPage> {
  var Scode;
  var yearCode;
  var userCode;
  var DayCode;
  Student student;
  @override
  Widget build(BuildContext context) {
    //print(widget.dayCode);
    student = ModalRoute.of(context).settings.arguments;
    setState(() {
      // if (Provider.of<APIService>(context, listen: false).usertype == "2"){
      //   Scode = Provider.of<APIService>(context, listen: false).code;
      //   userCode = Provider.of<APIService>(context, listen: false).usercode;
      //   yearCode =Provider.of<APIService>(context, listen: false).schoolYear;
      //   DayCode = widget.dayCode;
      // }
      // else if(Provider.of<APIService>(context, listen: false).usertype == "3" ||Provider.of<APIService>(context, listen: false).usertype == "4" ){
      //   Scode = (student.studentCode).toString();
      //   userCode = (student.userCode).toString();
      //   yearCode =Provider.of<APIService>(context, listen: false).schoolYear;
      //   DayCode = widget.dayCode;
      // }
      Scode = widget.Scode;
      userCode = widget.userCode;
      yearCode =Provider.of<APIService>(context, listen: false).schoolYear;
      DayCode = widget.dayCode;
    }
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
        actions: [
          Stack(
            children: [
              IconButton(
                  icon: Icon(Icons.notifications),
                  color: ColorSet.whiteColor,
                  iconSize: 25,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Notifi(
                            userCode:  userCode.runtimeType == String
                                ? int.parse( userCode)
                                :  userCode,
                            code: Scode,
                          )),
                    );
                  }),
              Positioned(
                right: 10,
                top: 10,
                child: FutureBuilder<AllCount>(
                    future: NotificationAllCount().getAllNotificationCount(
                        userCode.runtimeType == String
                            ? int.parse(userCode)
                            : userCode),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data.allNotification == '0'
                            ? Container(
                          height: 0,
                          width: 0,
                        )
                            : Container(
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              snapshot.data.allNotification,
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("error"));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )
            ],
          ),
        ],
        centerTitle: true,
        title: Text('${widget.DayNameEn}', style: AppTextStyle.headerStyle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
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
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder<List<DayScheduel>>(
          future: DayScheduelInfo().getDayScheduel(int.parse(Scode), yearCode, DayCode),
          builder:(context , snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Padding(
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
                              title: Text(snapshot.data[index].subjectNameEn , style: AppTextStyle.headerStyle2,),
                              subtitle: Text(snapshot.data[index].teacherNameEn, style: AppTextStyle.subtextgrey,),
                              trailing: Text("${(snapshot.data[index].startTime).substring(0,5)} : ${(snapshot.data[index].endTime).substring(0,5)}",style: AppTextStyle.subText,),
                            ),
                               //if(index == 2)
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 60),
                              //   child: Container(
                              //     height: 60,
                              //     width: 200,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.shade200,
                              //       borderRadius: BorderRadius.all(Radius.circular(15)),
                              //     ),
                              //     child: Center(child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text("Break" , style: AppTextStyle.headerStyle2,),
                              //        SizedBox(height: 5,),
                              //         Text("${(snapshot.data[2].endTime).substring(0,5)} : ${(snapshot.data[3].startTime).substring(0,5)}" ,style: AppTextStyle.subText ),
                              //       ],
                              //     ))
                              //   ),
                              // ),
                          ],
                        ),
                        isFirst: index == 0  ? true : false,
                        isLast: index == snapshot.data.length-1 ? true : false,
                      ),
                    ) ;
                  });
            }
            else if (snapshot.hasError){
              return Center(child: Text("error"));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          } ,
        )
      ),
    );
  }
}

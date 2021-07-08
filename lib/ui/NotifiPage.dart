import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_pro/api_services/PostUpdate.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/countByType_info.dart';
import 'package:lms_pro/api_services/notification_info.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/notification_data.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import '../Chat/ChatButton.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import 'NotifiNext.dart';

class Notifi extends StatefulWidget {
  final userCode;
  final code;

  const Notifi({Key key, this.userCode,this.code}) : super(key: key);
  @override
  _NotifiState createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {


  @override
  Widget build(BuildContext context) {
    print('from top notifi page ${widget.userCode}');
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            Navigator.pop(
              context,
            );
          }),
      centerTitle: true,
      title: Text("Notification", style: AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
    );
    return Scaffold(
      floatingActionButton: ChatButton(userCode: widget.userCode,code: widget.code,),
      appBar: MyAppBar,
      body: ListView(
        children: [
          //TRIP PENALTIES
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.exclamation,name: "Trip penalties",type: 1,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(1),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////BUS PENALTIES
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData:Icons.directions_bus_rounded,name: "Bus penalties",type: 2,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(2),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////VACCINATION
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.syringe,name: "Vaccination",type: 3,usercode:(widget.userCode).toString(),),
                getNotifiCountNum(3),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////TRIPS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: Icons.celebration,name: "Trips",type: 4,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(4),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////EVENTS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: Icons.calendar_today,name: "Events",type: 5,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(5),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////BEHAVIOUR
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.brain,name: "Behaviour",type: 6,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(6),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////ONLINEEXAMS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.stream,name: "Online Exams",type: 7,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(7),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////ONLINERESULT
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.clipboardCheck,name: "Quiz Results",type: 8,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(8),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////MATERIALS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.bookOpen,name: "Material",type: 9,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(9),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////EXAMSCHEDUEL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.calendarAlt,name: "Exam Schedule",type: 10,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(10),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////CERTIFICATE
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.certificate,name: "Certificates",type: 11,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(11),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////SEATS NUMBERS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.idCard,name: "Seating numbers",type: 12,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(12),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////WARNING
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.exclamationTriangle,name: "Warning",type: 13,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(13),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////Pathological complaints
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.userNurse,name: "Pathological complaints",type: 14,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(14),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////GENERAL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.info,name: "General",type: 15,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(15),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////Assignments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.bookmark,name: "Assignments",type: 1015,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(1015),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
          ////SURVEY
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                NotifiWidget(iconData: FontAwesomeIcons.poll,name: "Survey",type: 1016,usercode: (widget.userCode).toString(),),
                getNotifiCountNum(1016),
              ],
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  height: 1,
                  endIndent: 0.5,
                  color: Colors.grey.shade300,
                )),
          ),
        ],
      ),
    );
  }

  FutureBuilder<countByType> getNotifiCountNum( var type) {
    return FutureBuilder<countByType>(
                future: NotificationCountByType().getCountByType(widget.userCode.runtimeType==String?int.parse(widget.userCode):widget.userCode, type),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return snapshot.data.singleTypeCount == '0'?Container(height: 0,width: 0,): Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 25,
                          minHeight: 25,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${snapshot.data.singleTypeCount }',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        );
                  }
                  else if (snapshot.hasError){
                    return Center(child: Text('error'),);
                  }
                  return Container(height:0,width:0);
                },
              );
  }
}

class NotifiWidget extends StatelessWidget {
  final IconData iconData;
  final String name;
  final int type;
  final String usercode;

  const NotifiWidget({this.iconData, this.name, this.type,this.usercode}) ;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListTile(
          leading: Icon(
            iconData,
            color: ColorSet.primaryColor,
          ),
          title: Text(
            name,
            style: AppTextStyle.textstyle20,
          ),
          onTap: () {
            updateNotification updateModel = updateNotification();
            updateModel.userCode = usercode.toString();
            updateModel.Notificationtype = type.toString();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotifiNext(notifiType: type,NotifiName: name,userCode: usercode,)),
            );
            PostNotificationUpdate().NotificationUpdate(updateModel);
          },
        ),
      ),
    );
  }
}
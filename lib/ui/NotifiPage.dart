import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/notification_info.dart';
import 'package:lms_pro/models/notification_data.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/MyAppBar.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import 'NotifiNext.dart';

class Notifi extends StatefulWidget {
  final userCode;

  const Notifi({Key key, this.userCode}) : super(key: key);
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
      floatingActionButton: ChatButton(),
      appBar: MyAppBar,
      body: ListView(
        children: [
          //TRIP PENALTIES
          NotifiWidget(iconData: FontAwesomeIcons.exclamation,name: "Trip penalties",type: 1,usercode: (widget.userCode).toString(),),
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
         NotifiWidget(iconData:Icons.directions_bus_rounded,name: "Bus penalties",type: 2,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.syringe,name: "Vaccination",type: 3,usercode:(widget.userCode).toString(),),
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
          NotifiWidget(iconData: Icons.celebration,name: "Trips",type: 4,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: Icons.calendar_today,name: "Events",type: 5,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.brain,name: "Behaviour",type: 6,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.stream,name: "Online Exams",type: 7,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.clipboardCheck,name: "Quiz Results",type: 8,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.bookOpen,name: "Material",type: 9,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.calendarAlt,name: "Exam Schedule",type: 10,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.certificate,name: "Certificates",type: 11,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.idCard,name: "Seating numbers",type: 12,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.exclamationTriangle,name: "Warning",type: 13,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.userNurse,name: "Pathological complaints",type: 14,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.info,name: "General",type: 15,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.bookmark,name: "Assignments",type: 1015,usercode: (widget.userCode).toString(),),
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
          NotifiWidget(iconData: FontAwesomeIcons.poll,name: "Survey",type: 1016,usercode: (widget.userCode).toString(),),
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
            print("from notifi page ${usercode}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotifiNext(notifiType: type,NotifiName: name,userCode: usercode,)),
            );
          },
        ),
      ),
    );
  }
}

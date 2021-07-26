import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/models/bus_data.dart';
import 'package:lms_pro/api_services/bus_info.dart';
import 'package:lms_pro/utils/myBottomBar.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class Bus extends StatefulWidget {
  @override
  _BusState createState() => _BusState();
}

class _BusState extends State<Bus> {
  var usercode;
  var usertype;
  var schoolyear;
  var code;
  LoginResponseModel logInInfo;
  Student student;

  @override
  Widget build(BuildContext context) {
    // logInInfo = ModalRoute.of(context).settings.arguments;
    // schoolyear = logInInfo.schoolYearCode;
    student = ModalRoute
        .of(context)
        .settings
        .arguments;
    setState(() {
      if (Provider
          .of<APIService>(context, listen: false)
          .usertype == "2") {
        code = Provider
            .of<APIService>(context, listen: false)
            .code;
        schoolyear = Provider
            .of<APIService>(context, listen: false)
            .schoolYear;
      }
      else if (Provider
          .of<APIService>(context, listen: false)
          .usertype == "3" || Provider
          .of<APIService>(context, listen: false)
          .usertype == "4") {
        code = (student.studentCode).toString();
        schoolyear = Provider
            .of<APIService>(context, listen: false)
            .schoolYear;
      }
    }
    );
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: ColorSet.whiteColor,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: ColorSet.shadowcolour,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Column(
                children: [
//UPPER PART OF THE CARD
                  ListTile(
                    leading: Icon(
                      Icons.directions_bus_rounded,
                      color: ColorSet.primaryColor,
                    ),
                    title: Text(
                      "My Bus",
                      style: AppTextStyle.headerStyle2,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: ColorSet.SecondaryColor,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/BNV',);
                      },
                    ),
                  ),
//THE INFO IN THE CARD
                  FutureBuilder<BusData>(
                      future: BusInfo().getBus(int.parse(code), schoolyear),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data.busId == null
                              ? Center(
                                  child: Text(
                                  "No bus Info",
                                  style: AppTextStyle.headerStyle2,
                                ))
                              : Column(
                                  children: <Widget>[
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Bus Id:\n ${snapshot.data.busLabel}"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          VerticalDivider(
                                            color: Colors.grey,
                                            width: 1,
                                            thickness: 1,
                                            endIndent: 0.5,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "From:\n${(snapshot.data.zoneGoTime).substring(0, 5)} am"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          VerticalDivider(
                                              color: Colors.grey,
                                              width: 1,
                                              thickness: 1,
                                              endIndent: 0.5),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "To:\n${(snapshot.data.zoneBackTime).substring(0, 5)} pm"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.person_pin_rounded,
                                            color: ColorSet.primaryColor,
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                "Driver: ",
                                                style: AppTextStyle.headerStyle2,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  "${snapshot.data.driverName}",
                                                  style:
                                                  AppTextStyle.leadtextstyle,
                                                  maxLines: 1,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            ListTile(
                                              leading: Image(
                                                image: AssetImage(
                                                    'assets/images/driver.png'),
                                              ),
                                              subtitle: Text(
                                                "phone: ${snapshot.data.driverPhoneNumb}",
                                                style: AppTextStyle.leadtextstyle,
                                                  ),
                                              trailing:  IconButton(
                                                  icon: Icon(Icons.file_copy,
                                                      color:
                                                      ColorSet.SecondaryColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    Clipboard.setData(new ClipboardData(text: " ${snapshot.data.driverPhoneNumb}"));
                                                    Toast.show("Number was copied",context,duration:Toast.LENGTH_LONG);
                                                  }) ,
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.person_pin_rounded,
                                            color: ColorSet.primaryColor,
                                          ),
                                          title: Row(
                                            children: [
                                              Text(
                                                "Supervisor: ",
                                                style: AppTextStyle.headerStyle2,
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fill,
                                                child: Text(
                                                  "${snapshot.data.supervisorName}",
                                                  style: AppTextStyle.leadtextstyle,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 95,
                                          child: ListTile(
                                            leading: Image(
                                              image: AssetImage(
                                                  'assets/images/businesswoman.png'),
                                            ),
                                            subtitle: Text(
                                              "phone: ${snapshot.data.superPhoneNumb}",
                                              style: AppTextStyle.leadtextstyle,
                                            ),
                                            trailing:  IconButton(
                                                icon: Icon(Icons.file_copy,
                                                    color:
                                                    ColorSet.SecondaryColor,
                                                    size: 20),
                                                onPressed: () {
                                                  Clipboard.setData(new ClipboardData(text: " ${snapshot.data.superPhoneNumb}"));
                                                  Toast.show("Number was copied",context,duration:Toast.LENGTH_LONG);
                                                }),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                );
                        } else if (snapshot.hasError) {
                          return Text("error");
                        }
                        return CircularProgressIndicator();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
      //bottomNavigationBar: MyBottomBar(),
      );
  }
}
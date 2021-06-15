import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_pro/api_services/NotifiCountAll.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/editProfileData-info.dart';
import 'package:lms_pro/api_services/saveUserToken.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/NotificationModels.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/editProfileData.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/userTokenInfo.dart';
import 'package:lms_pro/ui/NotifiPage.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Chat/ChatButton.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../app_style.dart';
import '../localNotifi.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with ChangeNotifier {
  LoginResponseModel logInInfo;
  Student student;
  var usercode;
  var tryCode;
  var usertype;
  String EuserCode = '';
  String Epassword = '';
  String EfacebookUrl = '';
  String EtwitterUrl = '';
  String EinstgramUrl = '';
  String ElinkedinUrl = '';
  String Efile = '';
  EditProfile editProfile;
  static var code;
  var token;
  int NotCount = 0;
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    editProfile = EditProfile();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          NotCount++;
        });
        await PushNotificationService
            .showNotificationWithDefaultSoundWithDefaultChannel(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          NotCount++;
        });
        await PushNotificationService
            .showNotificationWithDefaultSoundWithDefaultChannel(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          NotCount++;
        });
        await PushNotificationService
            .showNotificationWithDefaultSoundWithDefaultChannel(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PushNotificationService.initializePlugin(context);
    student = ModalRoute.of(context).settings.arguments;
    setState(() {
      if (Provider.of<APIService>(context, listen: false).usertype == "2") {
        code = Provider.of<APIService>(context, listen: false).code;
        usercode = Provider.of<APIService>(context, listen: false).usercode;
      } else if (Provider.of<APIService>(context, listen: false).usertype ==
              "3" ||
          Provider.of<APIService>(context, listen: false).usertype == "4") {
        code = (student.studentCode).toString();
        usercode = (student.userCode).toString();
      }
    });

    firebaseMessaging.getToken().then((value) async {
      print('fcm token : ' + value);
      await SaveUserToken().Usertoken(UserToken(
        userCode: usercode,
        userToken: value,
        language: 'en',
      ));
    });

    //Coustume mde app bar
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            if (usertype == '2') {
              Navigator.pop(context);
            }
            // else if(usertype=='4'|| usertype=='3'){
            //   Navigator.popAndPushNamed(
            //     context,'/choose');
            // }
          }),
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
                              userCode: int.parse(usercode),
                              code: code,
                            )),
                  );
                }),
            Positioned(
              right: 10,
              top: 10,
              child: FutureBuilder<AllCount>(
                  future: NotificationAllCount().getAllNotificationCount(
                      usercode.runtimeType == String
                          ? int.parse(usercode)
                          : usercode),
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
        )
      ],
    );
    //Allowed height to work with
    var newheight = (MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom);
    return Scaffold(
      floatingActionButton: ChatButton(
        userCode: usercode,
        code: code,
      ),
      backgroundColor: ColorSet.whiteColor,
      appBar: MyAppBar,
      //Main widget in the page
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  Container(
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
                  FutureBuilder<Student>(
                      future: StudentData().SData(int.parse(code)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FittedBox(
                                child: CircleAvatar(
                                  backgroundImage: HttpStatus
                                              .internalServerError !=
                                          500
                                      ? NetworkImage(
                                          'http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${snapshot.data.imagePath}')
                                      : AssetImage('assets/images/student.png'),
                                  radius: 40.0,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("error");
                        }
                        return CircularProgressIndicator();
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, right: 30, left: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorSet.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorSet.shadowcolour,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(4, 3),
                      ),
                    ]),
                child: Center(
                    child: FutureBuilder<Student>(
                        future: StudentData().SData(int.parse(code)),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 5),
                                  child: FittedBox(
                                    child: Text(
                                      snapshot.data.sNameEN,
                                      style: AppTextStyle.headerStyle2,
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Stage: ${snapshot.data.stageNameEN}",
                                      style: AppTextStyle.textstyle15,
                                    ),
                                    Text(
                                      "Class:${snapshot.data.classNameEN}",
                                      style: AppTextStyle.textstyle15,
                                    ),
                                  ],
                                ),
                                //SOCIAL MEDIA CONTAINER
                                Container(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebook,
                                          color: ColorSet.SecondaryColor,
                                        ),
                                        onPressed: () async {
                                          print(snapshot.data.facebook);
                                          String url = snapshot.data.facebook;
                                          try {
                                            await canLaunch(url)
                                                ? await launch(url)
                                                : throw 'error';
                                          } catch (e) {
                                            Toast.show(
                                              "No account was found",
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                            );
                                          }
                                        },
                                      ),
                                      IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.twitter,
                                            color: ColorSet.SecondaryColor,
                                          ),
                                          onPressed: () async {
                                            print(snapshot.data.twitter);
                                            String url = snapshot.data.twitter;
                                            try {
                                              await canLaunch(url)
                                                  ? await launch(url)
                                                  : throw 'error';
                                            } catch (e) {
                                              Toast.show(
                                                "No account was found",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                              );
                                            }
                                          }),
                                      IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.linkedinIn,
                                            color: ColorSet.SecondaryColor,
                                          ),
                                          onPressed: () async {
                                            print(snapshot.data.linkedIn);
                                            String url = snapshot.data.linkedIn;
                                            try {
                                              await canLaunch(url)
                                                  ? await launch(url)
                                                  : throw 'error';
                                            } catch (e) {
                                              Toast.show(
                                                "No account was found",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                              );
                                            }
                                          }),
                                      IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.instagram,
                                            color: ColorSet.SecondaryColor,
                                          ),
                                          onPressed: () async {
                                            print(snapshot.data.instgram);
                                            String url = snapshot.data.instgram;
                                            try {
                                              await canLaunch(url)
                                                  ? await launch(url)
                                                  : throw 'error';
                                            } catch (e) {
                                              Toast.show(
                                                "No account was found",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 6, top: 10),
                                  child: InkWell(
                                    child: Text(
                                      "Change password?",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorSet.primaryColor),
                                    ),
                                    onTap: () => ChangePasswordDialog(),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("error");
                          }
                          return Center(child: CircularProgressIndicator());
                        })),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (Provider.of<APIService>(context, listen: false)
                                .usertype ==
                            "3" ||
                        Provider.of<APIService>(context, listen: false)
                                .usertype ==
                            "4") {
                      Navigator.pushNamed(context, '/subjects',
                          arguments: Student(
                            studentCode: int.parse(code),
                            userCode: student.userCode,
                          ));
                    } else if (Provider.of<APIService>(context, listen: false)
                            .usertype ==
                        "2") {
                      Navigator.pushNamed(context, '/subjects',
                          arguments: Student(
                            studentCode: int.parse(code),
                            userCode: int.parse(usercode),
                          ));
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Image(
                              image:
                                  AssetImage('assets/images/science-book.png')),
                        ),
                        Text(
                          "Courses",
                          style: AppTextStyle.headerStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Provider.of<APIService>(context, listen: false)
                                .usertype ==
                            "3" ||
                        Provider.of<APIService>(context, listen: false)
                                .usertype ==
                            "4") {
                      Navigator.pushNamed(context, '/recentassignment',
                          arguments: Student(
                            studentCode: int.parse(code),
                            userCode: student.userCode,
                          ));
                    } else if (Provider.of<APIService>(context, listen: false)
                            .usertype ==
                        "2") {
                      Navigator.pushNamed(context, '/recentassignment',
                          arguments: Student(
                            studentCode: int.parse(code),
                            userCode: int.parse(usercode),
                          ));
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Image(
                              image: AssetImage('assets/images/recntassi.png')),
                        ),
                        Text(
                          "Recent\nAssignment",
                          style: AppTextStyle.headerStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Provider.of<APIService>(context, listen: false)
                                .usertype ==
                            "3" ||
                        Provider.of<APIService>(context, listen: false)
                                .usertype ==
                            "4") {
                      Navigator.pushNamed(context, '/recentexam',
                          arguments: Student(
                            studentCode: int.parse(code),
                            userCode: student.userCode,
                          ));
                    } else if (Provider.of<APIService>(context, listen: false)
                            .usertype ==
                        "2") {
                      Navigator.pushNamed(context, '/recentexam',
                          arguments: Student(
                            studentCode: int.parse(code),
                            userCode: int.parse(usercode),
                          ));
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Image(
                              image: AssetImage('assets/images/courses.png')),
                        ),
                        Text(
                          "Recent\nExams",
                          style: AppTextStyle.headerStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: MyBottomBar(),
    );
  }

  ChangePasswordDialog() {
    var alert = AlertDialog(
      title: Center(
          child: Text(
        "Change password",
        style: AppTextStyle.headerStyle2,
      )),
      content: Form(
        key: FormKey,
        child: TextFormField(
          onSaved: (input) {
            editProfile.password = input;
            editProfile.userCode = usercode;
            editProfile.facebookUrl = " ";
            editProfile.twitterUrl = " ";
            editProfile.linkedinUrl = " ";
            editProfile.instgramUrl = " ";
            editProfile.file = " ";
          },
          validator: (val) => val.isEmpty ? "Enter your New password" : null,
          onChanged: (val) {
            setState(() {
              val = Epassword;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.remove_red_eye,
                color: ColorSet.primaryColor,
                size: 35.0,
              ),
            ),
            hintText: " New password",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorSet.borderColor),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: ColorSet.SecondaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: ColorSet.SecondaryColor),
          ),
          onPressed: () {
            if (validateAndSave()) {
              print(editProfile.toJson());
              EditMyProfile().EditProfileData(editProfile);
            }
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

  bool validateAndSave() {
    final _formKey = FormKey.currentState;
    if (FormKey.currentState.validate()) {
      FormKey.currentState.save();
      return true;
    }
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/ui/Bus.dart';
import 'package:lms_pro/ui/Events.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/LogInPage.dart';
import 'package:http/http.dart'as http;
import 'package:lms_pro/ui/Scheduel.dart';
import 'package:lms_pro/ui/SubjectPage.dart';
import 'package:lms_pro/ui/choose_student.dart';
import 'package:lms_pro/ui/subjectDetails.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/buildQuizPage.dart';
import 'package:lms_pro/utils/subjectAssignDetails.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider<APIService>(create: (_)=>APIService(),),
    ChangeNotifierProvider<StudentData>(create: (_)=>StudentData(),),
  ],
  child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    // home: LogIn(),
      initialRoute: '/LogIn',
      routes: {
        '/LogIn':(context) =>  LogIn(),
        '/choose':(context) => ChooseStudent(),
        '/events':(context) => Events(),
        '/home':(context) =>  Home(),
        '/scheduel':(context) => Scheduel(),
        '/bus':(context) => Bus(),
        '/BNV':(context) =>  BNV(),
        '/subjects':(context) =>  SubjectPage(),
        '/subjectassign':(context) =>  AssignmentDetails(),
        '/subjectdetils':(context) =>SubjectDetails(),
        '/quizdetils':(context) => QuizPageDetails(),
      },
    );
  }////13186F,123
}


import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/ui/Bus.dart';
import 'package:lms_pro/ui/Events.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/LogInPage.dart';
import 'package:http/http.dart'as http;
import 'package:lms_pro/ui/Scheduel.dart';
import 'package:lms_pro/ui/choose_student.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());


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
     home: ChangeNotifierProvider<APIService>(
         child: LogIn(),
       create: (_)=>APIService(),
     ),
      //initialRoute: '/',
      routes: {
        '/LogIn':(context) => ChangeNotifierProvider(child: LogIn(),create: (_)=>StudentData(),),
        '/choose':(context) => ChangeNotifierProvider(child: ChooseStudent(),create: (_)=>StudentData(),),
        '/events':(context) => Events(),
        '/home':(context) => ChangeNotifierProvider(child: Home(),create: (_)=>StudentData(),),
        '/scheduel':(context) => Scheduel(),
        '/bus':(context) => Bus(),
        '/BNV':(context) => ChangeNotifierProvider(child: BNV(),create: (_)=>StudentData(),),


      },
    );
  }////13186F,123
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Center();
  }
}

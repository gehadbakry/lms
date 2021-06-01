// import 'package:flutter/material.dart';
// import 'package:lms_pro/api_services/api_service.dart';
// import 'package:lms_pro/app_style.dart';
// import 'package:provider/provider.dart';
// class MyBottomBar extends StatefulWidget {
//   @override
//   _MyBottomBarState createState() => _MyBottomBarState();
// }
//
// class _MyBottomBarState extends State<MyBottomBar> {
//   var color;
//   bool tapHome;
//   bool tapevents;
//   bool tapScheduel;
//   bool tapCalendar;
//   var code;
//   var usercode;
//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//       if (Provider.of<APIService>(context, listen: false).usertype == "2") {
//         code = Provider.of<APIService>(context, listen: false).code;
//       } else if (Provider.of<APIService>(context, listen: false).usertype ==
//           "3" ||
//           Provider.of<APIService>(context, listen: false).usertype == "4") {
//         // code = (student.studentCode).toString();
//         // usercode = student.userCode;
//       }
//     });
//     return Container(
//       decoration: BoxDecoration(
//           color: ColorSet.whiteColor,
//           borderRadius:BorderRadius.only(topLeft:Radius.circular(15) ,topRight:Radius.circular(15) ),
//           boxShadow:[ BoxShadow(
//             color: ColorSet.shadowcolour,
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(4, 3),
//           ),]
//       ),
//       height: 55,
//       child: Padding(
//         padding: const EdgeInsets.only(top:6),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             GestureDetector(
//               child: Column(
//                 children: [
//                   Icon(Icons.home , color:ColorSet.inactiveColor,),
//                   Text("Home" , style: TextStyle(color: ColorSet.primaryColor),)
//                 ],
//               ),
//               onTap: (){
//                 Navigator.pushReplacementNamed(context, '/home');
//               },
//             ),
//             GestureDetector(
//               child: Column(
//                 children: [
//                   Icon(Icons.event_available , color: ColorSet.inactiveColor,),
//                   Text("Events",style: TextStyle(color: ColorSet.inactiveColor) )
//                 ],
//               ),
//               onTap: (){
//                 Navigator.pushReplacementNamed(context, '/events');
//               },
//             ),
//             GestureDetector(
//               child: Column(
//                 children: [
//                   Icon(Icons.timer_rounded , color: ColorSet.inactiveColor,),
//                   Text("Scheduel",style: TextStyle(color: ColorSet.inactiveColor))
//                 ],
//               ),
//               onTap: (){
//                 Navigator.pushReplacementNamed(context, '/scheduel');
//               },
//             ),
//             GestureDetector(
//               child: Column(
//                 children: [
//                   Icon(Icons.directions_bus_rounded,color: ColorSet.inactiveColor,),
//                   Text("Bus",style: TextStyle(color: ColorSet.inactiveColor))
//                 ],
//               ),
//               onTap: (){
//                 Navigator.pushReplacementNamed(context, '/bus');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

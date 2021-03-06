import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/ui/Bus.dart';
import 'package:lms_pro/ui/Events.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/Scheduel.dart';
import 'package:provider/provider.dart';
class BNV extends StatefulWidget {
  // final BuildContext menuScreenContext;
  // BNV({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _BNVState createState() => _BNVState();
}

class _BNVState extends State<BNV> {
  int _selectedIndex = 0;
  LoginResponseModel logInInfo;
  Student student;
   var usercode;
  var usertype;
  var schoolyear;
  var code;

  // PersistentTabController _controller;
  // bool _hideNavBar;


  // List<Widget> pages() {
  //   return [
  //     Home(
  //       menuScreenContext: widget.menuScreenContext,
  //       hideStatus: _hideNavBar,
  //       onScreenHideButtonPressed: () {
  //         setState(() {
  //           _hideNavBar = !_hideNavBar;
  //         });
  //       },
  //     ),
  //     Events(
  //       menuScreenContext: widget.menuScreenContext,
  //       hideStatus: _hideNavBar,
  //       onScreenHideButtonPressed: () {
  //         setState(() {
  //           _hideNavBar = !_hideNavBar;
  //         });
  //       },
  //     ),
  //     Scheduel(
  //       menuScreenContext: widget.menuScreenContext,
  //       hideStatus: _hideNavBar,
  //       onScreenHideButtonPressed: () {
  //         setState(() {
  //           _hideNavBar = !_hideNavBar;
  //         });
  //       },
  //     ),
  //     Bus(
  //       menuScreenContext: widget.menuScreenContext,
  //       hideStatus: _hideNavBar,
  //       onScreenHideButtonPressed: () {
  //         setState(() {
  //           _hideNavBar = !_hideNavBar;
  //         });
  //       },
  //     ),
  //   ];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems(){
  //   return [
  //     PersistentBottomNavBarItem(icon: Icon(Icons.home) , title: "Home" ,
  //         activeColorPrimary:ColorSet.primaryColor,
  //       inactiveColorPrimary: ColorSet.inactiveColor,
  //     ),
  //     PersistentBottomNavBarItem(icon: Icon(Icons.event_available) , title: "Events" ,
  //       activeColorPrimary:ColorSet.primaryColor,
  //       inactiveColorPrimary: ColorSet.inactiveColor,
  //     ),
  //     PersistentBottomNavBarItem(icon: Icon(Icons.timer_rounded) , title: "Schrduel" ,
  //       activeColorPrimary:ColorSet.primaryColor,
  //       inactiveColorPrimary: ColorSet.inactiveColor,
  //     ),
  //     PersistentBottomNavBarItem(icon: Icon(Icons.directions_bus_rounded) , title: "Bus" ,
  //       activeColorPrimary:ColorSet.primaryColor,
  //       inactiveColorPrimary: ColorSet.inactiveColor,
  //     ),
  //   ];
  // }

  // void initState() {
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  //   _hideNavBar = false;
  // }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => page[_selectedIndex]),
    // );
  }
  List page = [
    Home(),
    Events(),
    Scheduel(),
    Bus(),
  ];
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  @override
  Widget build(BuildContext context) {
    student = ModalRoute.of(context).settings.arguments;
    return Container(

      child: Scaffold(
        body: page[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home) , label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.event_available) ,label: "Events"),
                BottomNavigationBarItem(icon: Icon(Icons.timer_rounded),label: "Schecuel"),
                BottomNavigationBarItem(icon: Icon(Icons.directions_bus_rounded),label: "Bus"),
              ],
          currentIndex: _selectedIndex,
          elevation: 0.9,
          onTap: _onItemTapped,
           selectedItemColor: ColorSet.primaryColor,
          unselectedItemColor:  ColorSet.inactiveColor,
        ),
      ),
    );
  }
}
// class CustomNavBarWidget extends StatelessWidget {
//   final int selectedIndex;
//   final List<PersistentBottomNavBarItem> items;
//   final ValueChanged<int> onItemSelected;
//
//   CustomNavBarWidget({
//     Key key,
//     this.selectedIndex,
//     @required this.items,
//     this.onItemSelected,
//   });
//
//   Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
//     return Container(
//       alignment: Alignment.center,
//       height: kBottomNavigationBarHeight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Flexible(
//             child: IconTheme(
//               data: IconThemeData(
//                   size: 26.0,
//                   color: isSelected
//                       ? (item.activeColorSecondary == null
//                       ? item.activeColorPrimary
//                       : item.activeColorSecondary)
//                       : item.inactiveColorPrimary == null
//                       ? item.activeColorPrimary
//                       : item.inactiveColorPrimary),
//               child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Material(
//               type: MaterialType.transparency,
//               child: FittedBox(
//                   child: Text(
//                     item.title,
//                     style: TextStyle(
//                         color: isSelected
//                             ? (item.activeColorSecondary == null
//                             ? item.activeColorPrimary
//                             : item.activeColorSecondary)
//                             : item.inactiveColorPrimary,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.0),
//                   )),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Container(
//         width: double.infinity,
//         height: kBottomNavigationBarHeight,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: items.map((item) {
//             int index = items.indexOf(item);
//             return Flexible(
//               child: GestureDetector(
//                 onTap: () {
//                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>this.onItemSelected(index)),);
//                   this.onItemSelected(index);
//                 },
//                 child: _buildItem(item, selectedIndex == index),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

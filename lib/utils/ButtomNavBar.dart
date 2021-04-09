import 'package:flutter/material.dart';

import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/ui/Bus.dart';
import 'package:lms_pro/ui/Events.dart';
import 'package:lms_pro/ui/Home.dart';
import 'package:lms_pro/ui/Scheduel.dart';
class BNV extends StatefulWidget {
  @override
  _BNVState createState() => _BNVState();
}

class _BNVState extends State<BNV> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => pages[_selectedIndex]),
    // );
  }
  List pages = [
    Home(),
    Events(),
    Scheduel(),
    Bus(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
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
    );
  }
}

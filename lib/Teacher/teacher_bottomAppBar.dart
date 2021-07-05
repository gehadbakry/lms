import 'package:flutter/material.dart';
import 'package:lms_pro/Teacher/teacher_assignment.dart';
import 'package:lms_pro/Teacher/teacher_events.dart';
import 'package:lms_pro/Teacher/teacher_journey.dart';
import 'package:lms_pro/Teacher/teacher_quizzes.dart';
import 'package:lms_pro/Teacher/teacher_materials.dart';

import '../app_style.dart';
import '../testpage.dart';
class TeacherBottomAppBar extends StatefulWidget {
  final stageSubjectCode;

  const TeacherBottomAppBar({Key key, this.stageSubjectCode}) : super(key: key);
  @override
  _TeacherBottomAppBarState createState() => _TeacherBottomAppBarState();
}

class _TeacherBottomAppBarState extends State<TeacherBottomAppBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });}

  @override
  Widget build(BuildContext context) {
    List page = [
      TeacherMaterials(stageSubjectCode: widget.stageSubjectCode,),
      TeacherAssignments(stageSubjectCode:widget.stageSubjectCode ,),
      TeacherQuizzes(stageSubjectCode: widget.stageSubjectCode,),
      TeacherEvents(),
      TeacherJourneys(stageSubjectCode: widget.stageSubjectCode,),
    ];
    return Container(
      child: Scaffold(
        body: page[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu_book) , label: "Material"),
            BottomNavigationBarItem(icon: Icon(Icons.assignment) , label: "Assignments"),
            BottomNavigationBarItem(icon: Icon(Icons.quiz) , label: "Quizzes"),
            BottomNavigationBarItem(icon: Icon(Icons.event) , label: "Events"),
            BottomNavigationBarItem(icon: Icon(Icons.celebration) , label: "Journey"),
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

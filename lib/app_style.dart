import 'package:flutter/material.dart';

class ColorSet {
  static Color primaryColor = Color.fromRGBO(18, 100, 97, 1);
  static Color SecondaryColor = Color.fromRGBO(250, 228, 14, 1);
  static Color inactiveColor = Color.fromRGBO(126, 146, 146, 1);
  static Color notifiColor = Color.fromRGBO(241, 10, 10, 1);
  static Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static Color borderColor = Color.fromRGBO(77, 63, 63, 0.10);
  static Color shadowcolour = Color.fromRGBO(0,0, 0, 0.16);
}

class AppTextStyle {
  static TextStyle headerStyle = TextStyle(
      color: ColorSet.whiteColor, fontSize: 20, fontWeight: FontWeight.w700);
  static TextStyle headerStyle2 = TextStyle(
      color: ColorSet.primaryColor, fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle textstyle15 = TextStyle(
      color: ColorSet.primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.normal,);
  static TextStyle leadtextstyle = TextStyle(
      color: ColorSet.primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.bold);
  static TextStyle textstyle20 = TextStyle(
      color: ColorSet.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.normal);
  static TextStyle subText = TextStyle(
      color: ColorSet.SecondaryColor,
      fontSize: 15,
      fontWeight: FontWeight.w500);
  static TextStyle subject = TextStyle(
      color: ColorSet.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.bold);
  static TextStyle chap = TextStyle(
      color: ColorSet.SecondaryColor,
      fontSize: 8,
      fontWeight: FontWeight.normal);
  static TextStyle subtextgrey = TextStyle(
      color: ColorSet.inactiveColor,
      fontSize: 15,
      fontWeight: FontWeight.normal);
  static TextStyle complaint = TextStyle(
      color: ColorSet.notifiColor,
      fontSize: 15,
      fontWeight: FontWeight.bold);
}


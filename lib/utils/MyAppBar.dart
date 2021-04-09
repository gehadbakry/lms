import 'package:flutter/material.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/ui/NotifiPage.dart';

BuildContext context;
Widget coBar (String pageName){
  return AppBar(
    backgroundColor: ColorSet.primaryColor,
    elevation: 0.9,
    leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
        iconSize: 25,
        onPressed: (){
          Navigator.pop(
            context,);
        }) ,
    actions: [
      IconButton(icon: Icon(Icons.notifications),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notifi()),
            );
          })
    ],
    centerTitle: true,
    title: Text("$pageName", style:AppTextStyle.headerStyle),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
    ),
  );
}

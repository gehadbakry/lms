import 'package:flutter/material.dart';

import '../app_style.dart';
Widget BuildSubjectDetails(var page){

  return Container(
    decoration: BoxDecoration(
      color: ColorSet.whiteColor,
      borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(25),topStart: Radius.circular(25)),
    ),
    child: page,
  );
}
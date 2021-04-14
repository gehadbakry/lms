import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/MyAppBar.dart';

import '../app_style.dart';

class Notifi extends StatefulWidget {
  @override
  _NotifiState createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  @override
  Widget build(BuildContext context) {

    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
            Navigator.pop(
              context,);
          }) ,
      centerTitle: true,
      title: Text("Notification", style:AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      ),
    );

    return Scaffold(
      appBar: MyAppBar,
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context , index){
            return notifiTile(FontAwesomeIcons.syringe , "Vaccine");
          }),

    );
  }

  Column notifiTile(IconData icon , String title) {
    return Column(
            children: [
              ListTile(
                leading: FaIcon(icon,color: ColorSet.primaryColor,),
                title: Text(title , style: AppTextStyle.textstyle20,),
              ),
              Divider(height: 1.5,),
            ],
          );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import 'package:lms_pro/utils/MyAppBar.dart';

import '../app_style.dart';
import 'NotifiNext.dart';

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
      floatingActionButton: ChatButton(),
      appBar: MyAppBar,
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context , index){
            return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.syringe ,color: ColorSet.primaryColor,),
                      title: Text("Vaccine" , style: AppTextStyle.textstyle20,),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotifiNext()),
                        );
                      },

                    ),
                  ),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Divider(height: 2,color: Colors.black,)),
                  ),
                ],
              );
            //return notifiTile(FontAwesomeIcons.syringe , "Vaccine" ,NotifiNext(),);
          }),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:lms_pro/utils/customDrawer.dart';

import '../app_style.dart';
import 'NotifiPage.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {

    String mainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud";


    //CUSTOM APP BAR
    Widget myAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
            Navigator.pop(
              context);
          }) ,
      centerTitle: true,
      title: Text("Chat" ,style: AppTextStyle.headerStyle,),
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
    ) ;


    return Scaffold(
      appBar: myAppBar,
      body: Scaffold(
        backgroundColor: ColorSet.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorSet.whiteColor,
          iconTheme: IconThemeData(color:ColorSet.primaryColor),
          elevation: 0.0,
        ),
        drawer: CustomDrawer(),
        drawerEnableOpenDragGesture: true,
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/teacher.png'),
                    radius: 30.0,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("Teacher's name",style: AppTextStyle.headerStyle2,),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10 , bottom: 10),
                    child: Text(mainText , style:AppTextStyle.subtextgrey ,maxLines: 2,),
                  ),
                  //onTap: (){},
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Divider(height: 8,thickness: 1,)),
              ],
            ),
          );
        }),
      ),
    );
  }
}

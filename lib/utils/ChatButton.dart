import 'package:flutter/material.dart';
import 'package:lms_pro/app_style.dart';
import 'package:lms_pro/ui/mainChatPage.dart';

class ChatButton extends StatefulWidget {
  @override
  _ChatButtonState createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: ColorSet.SecondaryColor,
        child:Icon(Icons.chat,color: ColorSet.whiteColor,),
        onPressed: (){
          Navigator.push(context,  MaterialPageRoute(builder: (context) => ChatPage()));
        },);
  }
}

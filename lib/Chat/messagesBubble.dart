import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_style.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final userName;
  final isMe;
  final Date;

  const MessageBubble(
      {Key key,
      this.message,
      this.userName,
      this.isMe,
      this.Date,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: !isMe?EdgeInsets.only(top: 8,bottom: 8,right: 30,left: 10): EdgeInsets.only(top: 8,bottom: 8,right: 10,left: 30),
          child: Align(
            alignment: isMe?Alignment.centerLeft:Alignment.centerRight,
            child: Container(
                decoration: BoxDecoration(
                  color:!isMe?ColorSet.primaryColor:ColorSet.whiteColor ,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: isMe?Radius.circular(0): Radius.circular(10),
                    topEnd: !isMe?Radius.circular(0): Radius.circular(10),
                    bottomEnd:Radius.circular(10),
                    bottomStart:Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:  Colors.grey.shade300,
                      offset: Offset(2, 3),
                    ),
                  ]),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(message, style:TextStyle(color: !isMe?ColorSet.whiteColor:ColorSet.primaryColor)
                    ,textAlign: isMe?TextAlign.end:TextAlign.start,),
                )
            ),
          ),
        ),
        isMe?Align(
          alignment: Alignment.bottomLeft,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/student.png'),
            radius: 15.0,
          ),
        ):Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/student.png'),
            radius: 15.0,
          ),
        ),
      ],
    );
  }
}

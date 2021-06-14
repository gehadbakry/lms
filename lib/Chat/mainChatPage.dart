import 'package:flutter/material.dart';
import 'package:lms_pro/Chat/messagesPage.dart';
import 'package:lms_pro/api_services/ChatUser_info.dart';
import 'package:lms_pro/models/ChatUsers.dart';
import 'customDrawer.dart';

import '../app_style.dart';
import '../ui/NotifiPage.dart';

class ChatPage extends StatefulWidget {
  final code;
  final userCode;

  const ChatPage({Key key, this.code,this.userCode}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {

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
                MaterialPageRoute(builder: (context) => Notifi( userCode: widget.userCode, code:widget.code,)),
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
        body: FutureBuilder<List<ChatUsers>>(
          future: ChatUserInfo().getChatUsers(widget.code.runtimeType ==String?int.parse(widget.code):widget.code),
          builder: (context,snapshot){
    if (snapshot.hasData) {
      print(widget.code);
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/teacher.png'),
                      radius: 30.0,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('${snapshot.data[index].teacherNameAE}',style: AppTextStyle.headerStyle2,),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10 , bottom: 10),
                      child: Text('${snapshot.data[index].subjectNameAr}' , style:AppTextStyle.subtextgrey ,maxLines: 2,),
                    ),
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                      builder: (BuildContext context) => MessagePage(loggedIn:widget.userCode ,
                        reciver: snapshot.data[index].userCode,
                        code: widget.code,
                        TeacherName: snapshot.data[index].teacherNameAE,
                      subjectName: snapshot.data[index].subjectNameAr,
                      ),
            ));
            },
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Divider(height: 8,thickness: 1, color: Colors.grey.shade300,)),
                ],
              ),
            );
          });
    }
    else if(snapshot.hasError){
      return Center(child: CircularProgressIndicator(),);
    }
    return Center(child: CircularProgressIndicator(),);
          },
        ),


      ),
    );
  }
}

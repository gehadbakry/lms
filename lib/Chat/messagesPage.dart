import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/Chat/messagesBubble.dart';
import 'package:lms_pro/api_services/messages_info.dart';
import 'package:lms_pro/api_services/selectedChat_info.dart';
import 'package:lms_pro/models/messages.dart';
import 'package:lms_pro/models/selectedChat.dart';
import 'package:lms_pro/ui/NotifiPage.dart';

import '../app_style.dart';

class MessagePage extends StatefulWidget {
  final loggedIn;
  final reciver;
  final code;
  final TeacherName;
  final subjectName;

  const MessagePage(
      {Key key,
      this.loggedIn,
      this.reciver,
      this.code,
      this.TeacherName,
      this.subjectName})
      : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController messageController = TextEditingController();
  String message = '';
  bool isMe;
  Messages messageModel;

  @override
  void initState() {
    messageModel = Messages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            Navigator.pop(context);
          }),
      title: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.TeacherName,
                  style: AppTextStyle.headerStyle,
                )),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.subjectName,
                  style: TextStyle(fontSize: 13, color: ColorSet.whiteColor),
                )),
          ],
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
                icon: Icon(Icons.notifications),
                color: ColorSet.whiteColor,
                iconSize: 25,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Notifi(
                              userCode: widget.loggedIn.runtimeType == String
                                  ? int.parse(widget.loggedIn)
                                  : widget.loggedIn,
                              code: widget.code.runtimeType == String
                                  ? int.parse(widget.code)
                                  : widget.code,
                            )),
                  );
                }),
            Positioned(
              right: 10,
              top: 10,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: new Text(
                  '1',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        )
      ],
    );
    return Scaffold(
      appBar: MyAppBar,
      body: Column(
        children: [
          FutureBuilder<List<SelectedChat>>(
            future: SelectedChatInfo().getSelectedChat(
              widget.loggedIn.runtimeType == String ? int.parse(widget.loggedIn) : widget.loggedIn,
              widget.reciver.runtimeType == String ? int.parse(widget.reciver) : widget.reciver,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GroupedListView<SelectedChat,String>(
                    elements: snapshot.data.toList(),
                    groupBy: (SelectedChat e) => e.sentDate,
                    itemComparator: (item1, item2) => (DateTime.parse(item1.sentDate)).compareTo(DateTime.parse(item2.sentDate)),
                    groupHeaderBuilder:(SelectedChat e) => Container(height: 0.0,width:0.0),
                      itemBuilder: (context, SelectedChat e) => MessageBubble(
                        isMe:
                        e.senderCode == widget.reciver ? isMe = true : isMe = false,
                        message: e.messageBody,
                      ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('error'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                setState(() {
                  value = message;
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: ColorSet.primaryColor,
            onPressed: () {
              setState(() {
                messageModel.messageBody = messageController.text;
                messageModel.senderCode = widget.loggedIn.toString();
                messageModel.recieverCode = widget.reciver.toString();
              });
              SendMessage().sendMessage(messageModel);
              setState(() {
                messageController.text = '';
              });
            },
          ),
        ],
      ),
    );
  }
}

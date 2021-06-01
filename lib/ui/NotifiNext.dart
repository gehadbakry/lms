import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/notification_info.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/notification_data.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';

class NotifiNext extends StatefulWidget {
  final notifiType;
  final String NotifiName;
  final  userCode;
  NotifiNext({this.notifiType , this.NotifiName ,this.userCode});


  @override
  _NotifiNextState createState() => _NotifiNextState();
}

class _NotifiNextState extends State<NotifiNext> {
  @override

  Widget build(BuildContext context) {
    // setState(() {
    //   userCode = Provider.of<APIService>(context, listen: false).usercode;
    // });
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: () {
            Navigator.pop(
              context,
              //   MaterialPageRoute(builder: (context) => BNV()),
            );
          }),
      centerTitle: true,
      title: Text(widget.NotifiName, style: AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
    );

    return Scaffold(
        appBar: MyAppBar,
        body: FutureBuilder<List<Notifications>>(
          //future: NotificationInfo().getNotifications(9132),
          future: NotificationInfo().getNotifications(int.parse(widget.userCode)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                if (snapshot.data[index].type == widget.notifiType) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Card(
                        shadowColor: ColorSet.shadowcolour,
                        elevation: 9.0,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: ColorSet.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          title: Text(
                            snapshot.data[index].notificationnameEn,
                            style: AppTextStyle.textstyle20,
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                (snapshot.data[index].date).toString().substring(0,10),
                                style: AppTextStyle.subText,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "See more",
                                style: AppTextStyle.subText,
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              snapshot.data[index].notificationBodyEn,
                              style: AppTextStyle.textstyle15,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onTap: () => alertDialog(context,snapshot.data[index].notificationBodyEn,snapshot.data[index].notificationnameEn),
                        ),
                      ));
                }
                return Text('');
              });
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  void alertDialog(BuildContext context, String body,String name) {
    var alert = AlertDialog(
      title: ListTile(
        leading: Text(
          name,
          style: AppTextStyle.textstyle20,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.cancel_outlined,
            color: ColorSet.SecondaryColor,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      content: Text(body,style: AppTextStyle.textstyle15,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

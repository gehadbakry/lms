import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_style.dart';
class EventFunction{
  void JourneyFunction(var context,var Jname, var Jcost ,var JdateFrom,var JdateTo, var Jnotes ,var allowedComp ,var MaxStudents , var JfinalDate) {
    var alert = AlertDialog(
      title: Column(
        children: [
          ListTile(
            title: Text(Jname,style: TextStyle(color: Colors.purple ,fontSize: 15,fontWeight:FontWeight.bold),) ,
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('From: ${DateFormat.yMd().format(JdateFrom).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold) ,),
                Text('To: ${DateFormat.yMd().format(JdateTo).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Jnotes==null?Text(''):Text(Jnotes , style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500)) ,
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(height: 1,thickness: 2,),
          ),
        ],
      ),
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person , color: ColorSet.primaryColor ,),
                SizedBox(width: 3,),
                RichText(text: TextSpan(text: "Max No. of students :",style: TextStyle(color: ColorSet.primaryColor,fontSize: 13,fontWeight: FontWeight.bold),
                  children:<TextSpan>[TextSpan(text: MaxStudents.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance_wallet , color: ColorSet.primaryColor ,),
                SizedBox(width: 3,),
                RichText(text: TextSpan(text: "Cost :",style: TextStyle(color: ColorSet.primaryColor,fontSize: 13,fontWeight: FontWeight.bold),
                  children:<TextSpan>[TextSpan(text: Jcost.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                )),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
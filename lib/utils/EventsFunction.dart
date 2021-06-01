import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_style.dart';
class EventFunction{
  void JourneyFunction(var context,var Jname, var Jcost ,var JdateFrom,var JdateTo, var Jnotes ,var allowedComp ,var MaxStudents , var JfinalDate,var maxComp) {
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
      content: Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.person , color: Colors.purple ,),
                  SizedBox(width: 3,),
                  RichText(text: TextSpan(text: "Max No. of students :",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
                    children:<TextSpan>[TextSpan(text: MaxStudents.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                  )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.account_balance_wallet , color: Colors.purple,),
                  SizedBox(width: 3,),
                  RichText(text: TextSpan(text: "Cost :",style: TextStyle(color:ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
                    children:<TextSpan>[TextSpan(text: Jcost.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                  )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.group_add , color: Colors.purple,),
                  SizedBox(width: 3,),
                  Row(
                    children: [
                      Text("Company Allowed :",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold)),
                      allowedComp==true?Icon(Icons.check,color: ColorSet.inactiveColor,size: 20,):
                      Icon(Icons.cancel_outlined,color: ColorSet.inactiveColor,size: 20)
                    ],
                  ),
                ],
              ),
              allowedComp==true?Row(
                children: [
                  Icon(Icons.group , color: Colors.purple,),
                  SizedBox(width: 3,),
                  RichText(text: TextSpan(text: "Max NO of companions:",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
                    children:<TextSpan>[TextSpan(text: maxComp.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                  )),
                ],
              ):Text('')
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.purple),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void AbsenceFunction(var context,var Adate, var Anote ,var AreasonEn,var AreasonAr) {
    var alert =Anote==null?AlertDialog(
      content: Text("No notes to show", style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500)),
    ): AlertDialog(
      title: Column(
        children: [
          ListTile(
            title: Text(AreasonEn,style: TextStyle(color: Colors.green ,fontSize: 15,fontWeight:FontWeight.bold),) ,
            trailing: Text('Date: ${DateFormat.yMd().format(Adate).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold) ,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(height: 1,thickness: 2,),
          ),
        ],
      ),
      content: Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child:  Text(Anote , style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500)) ,
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void VaccineFunction(var context,var Vdate, var Vnote ,var VnameEn,var VnameAr) {
    var alert =Vnote==null?AlertDialog(
      content: Text("No notes to show", style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500)),
    ): AlertDialog(
      title: Column(
        children: [
          ListTile(
            title: Text(VnameEn,style: TextStyle(color: Colors.blue ,fontSize: 15,fontWeight:FontWeight.bold),) ,
            trailing: Text('Date: ${DateFormat.yMd().format(Vdate).toString().substring(0,10)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold) ,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(height: 1,thickness: 2,),
          ),
        ],
      ),
      content: Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child:  Center(child: Text(Vnote , style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500))) ,
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void EventsFunction(var context,var Edate, var EnameEn ,var EnameAr,var EdescEn ,var EdescAr ,var Ecost ,var Etime,var Elocation) {
    var alert = AlertDialog(
      title: Column(
        children: [
          ListTile(
            title: Text(EnameEn,style: TextStyle(color: Colors.brown ,fontSize: 15,fontWeight:FontWeight.bold),) ,
            trailing: Text('Date: ${DateFormat.yMd().format(Edate).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold) ,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(height: 1,thickness: 2,),
          ),
        ],
      ),
      content:Container(
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.location_on , color: Colors.brown ,),
                SizedBox(width: 3,),
                RichText(text: TextSpan(text: "Event location:",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
                  children:<TextSpan>[TextSpan(text: Elocation,style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.account_balance_wallet , color: Colors.brown,),
                SizedBox(width: 3,),
                RichText(text: TextSpan(text: "Cost :",style: TextStyle(color:ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
                  children:<TextSpan>[TextSpan(text: Ecost.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                )),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time , color: Colors.brown,),
                SizedBox(width: 3,),
                RichText(text: TextSpan(text: "Event time:",style: TextStyle(color:ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold),
                  children:<TextSpan>[TextSpan(text: Etime.toString(),style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12, ))],
                )),
              ],
            ),
            (EdescEn!=null || EdescAr!=null)?Row(
              children: [
                Icon(Icons.event_available , color: Colors.brown,),
                SizedBox(width: 3,),
                Row(
                  children: [
                    Text( "Event Desc:",style: TextStyle(color:  ColorSet.inactiveColor,fontSize: 13,fontWeight: FontWeight.bold)),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text( EdescEn,style:TextStyle(color: ColorSet.inactiveColor,fontSize: 12,),maxLines: 3,)),
                  ],
                ),
                ],
            ):Text('')
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.brown),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void ViolationFunction(var context,var Viodate, var Vionote ,var VionameAr,var VionameEn) {
    var alert =AlertDialog(
      title: Column(
        children: [
          ListTile(
            title: VionameEn.toString().length>20?Text('Violation', style: TextStyle(color: Colors.red , fontSize: 15 , fontWeight: FontWeight.bold),
              maxLines: 1,)
                : Text(VionameEn,style: TextStyle(color: Colors.red ,fontSize: 15,fontWeight:FontWeight.bold),) ,
            trailing: Text('Date: ${DateFormat.yMd().format(Viodate).toString().substring(0,9)}',style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 12,fontWeight: FontWeight.bold) ,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(height: 1,thickness: 2,),
          ),
        ],
      ),
      content:Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: VionameEn.toString().length>20?Column(
            children: [
              Center(child: Text(VionameEn , style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500))),
              Vionote==null?Text(""):Center(child: Text(Vionote , style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500),)) ,
            ],
          ):
          Vionote==null?Text(""):Center(child: Text(Vionote , style:TextStyle(color: ColorSet.inactiveColor ,fontSize: 13,fontWeight: FontWeight.w500))) ,
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }

}
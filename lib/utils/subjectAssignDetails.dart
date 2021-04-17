import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_style.dart';

class AssignmentDetails extends StatefulWidget {
  @override
  _AssignmentDetailsState createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  // String oType = "Online";
  // String ofType = "Offline",
  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context , index){
      return Padding(
        padding: const EdgeInsets.only(left: 15 , right: 15 ,top: 20),
        child: Card(
          shadowColor: ColorSet.shadowcolour,
          elevation: 9.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorSet.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: LayoutBuilder(builder:(context , constraints){
            return ListTile(
              title: Row(
                children: [
                  Text("Assignment Name" , style: AppTextStyle.headerStyle2,),
                  //SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                  Spacer(),
                  Text("10/10/10" , style: AppTextStyle.subText,),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Type",style: AppTextStyle.subText,),
                  Center(
                    child: RaisedButton(
                        child: Text("Show Assignment"),
                        textColor: ColorSet.whiteColor,
                        color: ColorSet.SecondaryColor,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(18.0),
                         ),
                        onPressed: (){}),
                  ),
                  Row(
                    children: [
                      Checkbox(value: this.valuefirst,
                          onChanged: (bool value) {
                            setState(() {
                              this.valuefirst = value;
                            });
                          },
                      focusColor: ColorSet.primaryColor,
                      ),
                      SizedBox(width: 2,),
                      Text("Assignment Done" ,style: AppTextStyle.subtextgrey,),
                      //SizedBox(width: MediaQuery.of(context).size.width*0.09,),
                      Spacer(),
                      Text("Result : 10" , style: AppTextStyle.headerStyle2,),
                    ],
                  ),
                ],
              ),
            );
          } ,
          ),
        ),
      );
    });

  }
}

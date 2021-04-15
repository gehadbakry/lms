import 'package:flutter/material.dart';

import '../app_style.dart';
///////should take arguments 1.either from recent assign or exams 2.date 3.arguments to build the card

Widget buildPage(){
  return ListView.builder(
    itemBuilder: (BuildContext context , index){
      return Padding(
        padding: const EdgeInsets.only(left: 15 , right: 15 ,top: 10),
        child: Card(
          shadowColor: ColorSet.shadowcolour,
          elevation: 9.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorSet.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: Text("Assignment Name" , style: AppTextStyle.textstyle20,),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("10/10/10" , style: AppTextStyle.subText,),
                SizedBox(height: 15,),
               Text("Result:10" , style: AppTextStyle.headerStyle2,),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Type" , style: AppTextStyle.subText,),
                Text("Some Assignment Discreption" , style: AppTextStyle.textstyle15,
                  maxLines: 1,overflow: TextOverflow.ellipsis,),
              ],
            ),
            //onTap: ,
                ),
          ),
      );
    },
    itemCount: 30,


  );
}
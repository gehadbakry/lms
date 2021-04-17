import 'package:flutter/material.dart';

import '../app_style.dart';
///////should take arguments 1.either from recent assign or exams 2.date 3.arguments to build the card
String mainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud";

class buildPage extends StatefulWidget {
  @override
  _buildPageState createState() => _buildPageState();
}

class _buildPageState extends State<buildPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Card(
            shadowColor: ColorSet.shadowcolour,
            elevation: 9.0,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorSet.borderColor, width: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "Assignment Name", style: AppTextStyle.textstyle20,),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("10/10/10", style: AppTextStyle.subText,),
                  Spacer(),
                  Text("Result:10", style: AppTextStyle.headerStyle2,),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Type", style: AppTextStyle.subText,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(mainText, style: AppTextStyle.textstyle15,
                      maxLines: 1, overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),
              onTap: () => alertDialog(context),
            ),
          ),
        );
      },
      itemCount: 30,

    );
  }


  void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: ListTile(
        leading: Text("Assignment Name", style: AppTextStyle.textstyle20,),
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
      content: Text(mainText, style: AppTextStyle.textstyle15,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0),
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
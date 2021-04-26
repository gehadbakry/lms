import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_style.dart';

String mainText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud";

class QuizPageDetails extends StatefulWidget {
  @override
  _QuizPageDetailsState createState() => _QuizPageDetailsState();
}

class _QuizPageDetailsState extends State<QuizPageDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Card(
              shadowColor: ColorSet.shadowcolour,
              elevation: 9.0,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: ColorSet.borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            "Quiz Name",
                            style: AppTextStyle.headerStyle2,
                          ),
                          //SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                          Spacer(),
                          Text(
                            "10/10/10",
                            style: AppTextStyle.subText,
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            mainText,
                            style: AppTextStyle.textstyle15,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          "Show Rank",
                          style: AppTextStyle.subText,
                        ),
                      ],
                    ),
                    onTap: () => alertDialog(context),
                  );
                },
              ),
            ),
          );
        });
  }

  void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Column(
        children: [
          Container(
            child: ListTile(
              title: Row(
                children: [
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Student Name",
                        style: AppTextStyle.headerStyle2,
                      )),
                  Spacer(),
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Rank:100/100",
                        style: AppTextStyle.subtextgrey,
                      )),
                ],
              ),
              subtitle: Row(
                children: [
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Exam name",
                        style: AppTextStyle.subText,
                      )),
                  Spacer(),
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Result:10/10",
                        style: AppTextStyle.subtextgrey,
                      )),
                ],
              ),
            ),
          ),
          Divider(
            height: 5,
            color: Colors.grey,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10),
                  child: Center(
                    child: Text(
                      "Statistics",
                      style: AppTextStyle.complaint,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      Text(
                        "Students",
                        style: AppTextStyle.subtextgrey,
                      ),
                      Spacer(),
                      Text("Marks", style: AppTextStyle.subtextgrey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: TextStyle(color: ColorSet.SecondaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      content: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: Row(
           children: [
             Text("10"),
             Spacer(),
             Text("10"),
           ],
          ),
        );
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

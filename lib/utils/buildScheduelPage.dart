import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_style.dart';
class ScheduelPage extends StatefulWidget {
  @override
  _ScheduelPageState createState() => _ScheduelPageState();
}

class _ScheduelPageState extends State<ScheduelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSet.whiteColor,
      child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25,top: 30),
                child: TimelineTile(
                  indicatorStyle: IndicatorStyle(
                    color: ColorSet.primaryColor,
                    indicatorXY: 0.4,
                    drawGap: true,
                  ),
                  endChild: ListTile(
                    title: Text("English" , style: AppTextStyle.headerStyle2,),
                    subtitle: Text("Teacher Name\nDetails" , style: AppTextStyle.subtextgrey,),
                    trailing: Text("8:00 Am : 8:30 Am",style: AppTextStyle.subText,),
                  ),
                  isFirst: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: TimelineTile(
                  indicatorStyle: IndicatorStyle(
                    color: ColorSet.primaryColor,
                  ),
                  endChild: ListTile(
                    title: Text("English" , style: AppTextStyle.headerStyle2,),
                    subtitle: Text("Teacher Name\nDetails" , style: AppTextStyle.subtextgrey,),
                    trailing: Text("8:00 Am : 8:30 Am",style: AppTextStyle.subText,),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

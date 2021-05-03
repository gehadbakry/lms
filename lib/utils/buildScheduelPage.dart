import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/day_scheduel_info.dart';
import 'package:lms_pro/models/day_scheduel.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_style.dart';
class ScheduelPage extends StatefulWidget {
  final int dayCode;

  const ScheduelPage({Key key, this.dayCode}) : super(key: key);
  @override
  _ScheduelPageState createState() => _ScheduelPageState();
}

class _ScheduelPageState extends State<ScheduelPage> {
  var Scode;
  var yearCode;
  var DayCode;
  @override
  Widget build(BuildContext context) {
    //print(widget.dayCode);
    setState(() {
      Scode = Provider.of<APIService>(context, listen: false).code;
      yearCode =Provider.of<APIService>(context, listen: false).schoolYear;
      DayCode = widget.dayCode;
    });
    return Container(
      color: ColorSet.whiteColor,
      padding: EdgeInsets.only(top: 20),
      child: FutureBuilder<List<DayScheduel>>(
        future: DayScheduelInfo().getDayScheduel(int.parse(Scode), yearCode, DayCode),
        builder:(context , snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TimelineTile(
                      indicatorStyle: IndicatorStyle(
                        color: ColorSet.primaryColor,
                        indicatorXY: 0.4,
                        drawGap: true,
                      ),
                      endChild: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data[index].subjectNameEn , style: AppTextStyle.headerStyle2,),
                            subtitle: Text(snapshot.data[index].teacherNameEn, style: AppTextStyle.subtextgrey,),
                            trailing: Text("${(snapshot.data[index].startTime).substring(0,5)} : ${(snapshot.data[index].endTime).substring(0,5)}",style: AppTextStyle.subText,),
                          ),
                            if(index == 2)
                            Padding(
                              padding: const EdgeInsets.only(right: 60),
                              child: Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Break" , style: AppTextStyle.headerStyle2,),
                                   SizedBox(height: 5,),
                                    Text("${(snapshot.data[2].endTime).substring(0,5)} : ${(snapshot.data[3].startTime).substring(0,5)}" ,style: AppTextStyle.subText ),
                                  ],
                                ))
                              ),
                            ),
                        ],
                      ),
                      isFirst: index == 0  || index == 3? true : false,
                      isLast: index == 8 || index == 2? true : false,
                    ),
                  ) ;
                });
          }
          else if (snapshot.hasError){
            return Center(child: Text("error"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        } ,
      )
    );
  }
}

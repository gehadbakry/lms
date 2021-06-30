import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherAssignments.dart';
import 'package:lms_pro/teacher_models/teacher_assignment_model.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';

class TeacherAssignments extends StatefulWidget {
  final stageSubjectCode;

  const TeacherAssignments({Key key, this.stageSubjectCode}) : super(key: key);
  @override
  _TeacherAssignmentsState createState() => _TeacherAssignmentsState();
}

class _TeacherAssignmentsState extends State<TeacherAssignments> {
  int code;
  int SchoolYear;
  int subjestStageCode;
  @override
  Widget build(BuildContext context) {
    setState(() {
      code = int.parse(Provider.of<APIService>(context, listen: false).code);
      SchoolYear = Provider.of<APIService>(context, listen: false).schoolYear;
      subjestStageCode = widget.stageSubjectCode;
    });
    return Scaffold(
        backgroundColor: ColorSet.primaryColor,
        floatingActionButton: Container(
          width: 155,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(45.0))),
            backgroundColor: ColorSet.SecondaryColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: ColorSet.whiteColor),
                  Text("Add Assignment",
                      style:
                          TextStyle(fontSize: 14, color: ColorSet.whiteColor))
                ],
              ),
            ),
            onPressed: () {},
          ),
        ),
        appBar: AppBar(
          backgroundColor: ColorSet.primaryColor,
          elevation: 0.0,
          title: Text(
            "Assignments",
            style: AppTextStyle.headerStyle,
          ),
          centerTitle: true,
        ),
        body: Container(
            decoration: BoxDecoration(
              color: ColorSet.whiteColor,
              borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 65),
            child: FutureBuilder<List<TeacherAssignment>>(
              future: TeacherAssignmentInfo().getTeacherAssignmentInfo(11, 169),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return GroupedListView<TeacherAssignment,int>(
                      elements: snapshot.data.toList(),
                      groupBy: (TeacherAssignment e) => e.assignCode,
                     groupHeaderBuilder: (TeacherAssignment e) {
                       return Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(
                                 right: 20, left: 20, top: 7, bottom: 10),
                             child: Container(
                               width: MediaQuery.of(context).size.width * 0.8,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(8)),
                                 color: ColorSet.whiteColor,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.withOpacity(0.4),
                                     spreadRadius: 3,
                                     blurRadius: 5,
                                     offset:
                                     Offset(4, 2), // changes position of shadow
                                   ),
                                 ],
                               ),
                               child: ListTile(
                                 leading: Text(
                                   e.assignmentName,
                                   style: AppTextStyle.headerStyle2,
                                 ),
                                 trailing: Icon(
                                   Icons.arrow_forward_ios_outlined,
                                   color: ColorSet.primaryColor,
                                 ),
                                 onTap: (){}
                                 ),
                             ),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               IconButton(onPressed: (){}, icon:Icon(Icons.add,color: ColorSet.SecondaryColor,) ),
                               IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: ColorSet.primaryColor,) ),
                               IconButton(onPressed: (){}, icon:Icon(Icons.delete,color: Colors.red,)),
                             ],
                           ),
                         ],
                       );
                     },
                      itemBuilder: (context, TeacherAssignment e) {
                    return null;
                  },
                order: GroupedListOrder.ASC,
                  );
                }
                else if(snapshot.hasError){
                  return Center(child: Text("error"),);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
           ));
  }
}

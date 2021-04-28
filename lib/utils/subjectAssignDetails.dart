import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/assignment_info.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/models/Assignment.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';
import '../app_style.dart';

class AssignmentDetails extends StatefulWidget {
  @override
  _AssignmentDetailsState createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  bool valuefirst = false;
  LoginResponseModel logInInfo;
  LoginRequestModel loginRequestModel;
  Subject subject;
  var code;
  var subjectCode;

  @override
  void initState() {
    loginRequestModel = LoginRequestModel();
    subject = Subject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context).settings.arguments;
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
      subjectCode = subject.subjectCode;
    });
    //AssignmentInfo().getAssignment(int.parse(code),subject.subjectCode );
    return Container(
      child: FutureBuilder<List<Assignment>>(
          future: AssignmentInfo().getAssignment(
              int.parse(code), subjectCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 20),
                        child: Card(
                          shadowColor: ColorSet.shadowcolour,
                          elevation: 9.0,
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorSet.borderColor, width: 0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(snapshot.data[index].assignmentName,
                                    style: AppTextStyle.headerStyle2,),
                                  Spacer(),
                                  Text("10/10/10", style: AppTextStyle.subText,),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Type", style: AppTextStyle.subText,),
                                  Center(
                                    ////WIDGET RETURNED ACCORDING TO TYPE EITHER ONLINE OR OFFLINE
                                    child: snapshot.data[index].type == 1
                                        ? RaisedButton(
                                        child: Text("Show Assignment"),
                                        textColor: ColorSet.whiteColor,
                                        color: ColorSet.SecondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18.0),
                                        ),
                                        onPressed: () {})
                                        : RaisedButton(
                                        child: Text("Show Assignment"),
                                        textColor: ColorSet.whiteColor,
                                        color: ColorSet.SecondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18.0),
                                        ),
                                        onPressed: () {}),
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
                                      Text("Assignment Done",
                                        style: AppTextStyle.subtextgrey,),
                                      Spacer(),
                                      Text("Result : 10",
                                        style: AppTextStyle.headerStyle2,),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          ),
                        ),
                      );
                    });
              }
              else {
                return Center(
                  child: Text(
                    "There is no Assignments", style: AppTextStyle.headerStyle2,),
                );
              }
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text("Error", style: AppTextStyle.headerStyle2,),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          })
    );
  }
}
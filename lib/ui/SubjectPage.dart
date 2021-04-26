import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import 'package:lms_pro/ui/subjectDetails.dart';
import 'package:lms_pro/utils/ChatButton.dart';
import '../app_style.dart';
import 'package:lms_pro/api_services/subjects_info.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  LoginResponseModel logInInfo;
  Subject subject;
  var code;


  @override

  Widget build(BuildContext context) {
    logInInfo = ModalRoute.of(context).settings.arguments;
    code = logInInfo.code;
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: ColorSet.whiteColor,
            iconSize: 25,
            onPressed: () {
                Navigator.popAndPushNamed(context,'/BNV',arguments: LoginResponseModel(code: code));
              // else if(usertype=='4'|| usertype=='3'){
              //   Navigator.popAndPushNamed(
              //     context,'/choose');
              // }
            }),
        actions: [
          IconButton(icon: Icon(Icons.notifications),
              color: ColorSet.whiteColor,
              iconSize: 25,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifi()),
                );
              })
        ],
      ) ,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorSet.whiteColor,
          borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(25),topStart: Radius.circular(25)),
        ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 5 , right: 8),
            child:FutureBuilder<List<Subject>>(
              future: SubjectInfo().getSubjects(int.parse(code)),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: (MediaQuery.of(context).size.width)*0.4,
                        childAspectRatio: 0.5,
                        crossAxisSpacing:5,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                              return  GestureDetector(
                                child:Column(
                                  children: [
                                    Container(
                                      width: 108,
                                      height: 121,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorSet.shadowcolour,
                                              blurRadius: 7,
                                              offset: Offset(5,3),
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage("http://169.239.39.105/LMS_site_demo/Home/GetImg?path=F:/docs${snapshot.data[index].imgPath}"),
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Container(
                                      width: 130,
                                      child: ListTile(
                                        title: Text(snapshot.data[index].subjectNameEn , style:TextStyle(
                                            color: ColorSet.primaryColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),maxLines: 2,),
                                        subtitle: Text(snapshot.data[index].teacherNameEn , style: TextStyle(
                                              color: ColorSet.inactiveColor,
                                              fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        ),
                                            maxLines: 2,
                                          ),

                                        trailing: Text("Ch.${snapshot.data[index].numberChapters}" , style: TextStyle(
                                            color: ColorSet.SecondaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                      ),
                                    ),
                                  ],
                                ) ,
                                onTap: (){
                                  Navigator.pushNamed(context, '/subjectdetils',arguments:Subject(
                                    subjectCode: snapshot.data[index].subjectCode,
                                    subjectNameEn: snapshot.data[index].subjectNameEn,
                                    teacherNameEn: snapshot.data[index].teacherNameEn,
                                    teacherImg: snapshot.data[index].teacherImg,
                                  ) );
                                  //Navigator.pushNamed(context, '/subjectdetils',arguments:LoginResponseModel(code: code) );
                                },
                              );
                      });
                }
                else if(snapshot.hasError){
                  return Text("error");
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          )
      ),
      floatingActionButton: ChatButton(),
    );
  }

}
class ArgumentsClass {
  final  LoginResponseModel logInInfo;
  final Subject subject;
  ArgumentsClass({this.subject,this.logInInfo});
}

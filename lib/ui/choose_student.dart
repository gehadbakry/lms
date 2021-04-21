import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/app_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/ui/SubjectPage.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class ChooseStudent extends StatefulWidget {
  @override
  _ChooseStudentState createState() => _ChooseStudentState();
}

class _ChooseStudentState extends State<ChooseStudent> {
  static final route = '/choose';
  LoginResponseModel logInInfo;
  List <String> ChildrenCodes = new List<String>();
@override
  Widget build(BuildContext context) {
    logInInfo = ModalRoute.of(context).settings.arguments;
    ChildrenCodes = (logInInfo.childrenCode).split(",");

    return Scaffold(
      backgroundColor: ColorSet.whiteColor,
      //Page body
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(-328.0, 268.0),
            child: Transform.rotate(
              angle: 0.3665,
              child: Container(
                width: 814.0,
                height: 709.0,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  gradient: LinearGradient(
                    begin: Alignment(1.12, 1.37),
                    end: Alignment(-0.21, -0.95),
                    colors: [ColorSet.primaryColor, ColorSet.whiteColor],
                    stops: [0.0, 1.0],
                  ),
                  //border: Border.all(width: 1.0, color: ColorSet.borderColor),
                ),
              ),
            ),
          ),
          Center(
            child: CarouselSlider.builder(itemCount: ChildrenCodes.length-1,
                itemBuilder: (_, int index, int realIndex){
              return StudentCard(context);
                },
                options: CarouselOptions(
                  height: 310,
                  autoPlay: false,
                  initialPage: 0,
                enableInfiniteScroll: false,
                )) ,
          )
        ],
      ),
    );
  }

  Container StudentCard(BuildContext context) {
    return Container(
            height: 400,
            width: 400,
            //CARD AND AVATAR STACK
            child: Stack(
                children: [
                  Center(
                    child: Card(
                      color: ColorSet.whiteColor,
                      shadowColor: ColorSet.shadowcolour,
                      elevation: 9.0,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: ColorSet.borderColor, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: 190,
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Column(
                            children:  <Widget>[
                              ListTile(
                                title: Text("Student Name",style: AppTextStyle.headerStyle2,),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text("Stage : prim \nClass: A",style: AppTextStyle.textstyle15,),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: ElevatedButton(
                                      onPressed: (){
                                        for(int index = 0;index <ChildrenCodes.length-1 ; index++ ){
                                          Provider.of<StudentData>(context,listen: false).SData(int.parse(ChildrenCodes[index],onError: (source)=>0)).then((value) {

                                          });
                                        }
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => BNV()),
                                      // );
                                    },
                                      child: Text("Go",
                                        style: TextStyle(color: ColorSet.primaryColor),),
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorSet.SecondaryColor,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                      ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FractionalTranslation(
                    translation: Offset(0.0, -0.0001),
                    child: Align(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/student.png'),
                        radius: 50.0,
                      ),
                     alignment: Alignment.topCenter,
                     // alignment: FractionalOffset(0.5, 0.39),
                    ),
                  ),

                ],
              ),
          );
  }
}

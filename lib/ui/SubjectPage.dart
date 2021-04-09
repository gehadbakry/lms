import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/testpage.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:lms_pro/ui/NotifiPage.dart';
import '../app_style.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override

  Widget build(BuildContext context) {
    
    
    List<Map<String , dynamic>> Subjectdata =[{
      "cont":context,
    "imageurl":'assets/images/Arabic.jpg',
    "language":"Language",
    "chapter":2,
    "name":"Teacher name",
    "rout" : Test(),
    },
      {
        "cont":context,
        "imageurl":"assets/images/Arabic.jpg",
        "language":"Language",
        "chapter":2,
        "name":"Teacher name",
        "rout" : Test(),
      },
      {
        "cont":context,
        "imageurl":"assets/images/Arabic.jpg",
        "language":"Language",
        "chapter":2,
        "name":"Teacher name",
        "rout" : Test(),
      },
      {
        "cont":context,
        "imageurl":"assets/images/Arabic.jpg",
        "language":"Language",
        "chapter":2,
        "name":"Teacher name",
        "rout" : Test(),
      },
      {
        "cont":context,
        "imageurl":"assets/images/Arabic.jpg",
        "language":"Language",
        "chapter":2,
        "name":"Teacher name",
        "rout" : Test(),
      },
      {
        "cont":context,
        "imageurl":"assets/images/Arabic.jpg",
        "language":"Language",
        "chapter":2,
        "name":"Teacher name",
        "rout" : Test(),
      },
      {
        "cont":context,
        "imageurl":"assets/images/Arabic.jpg",
        "language":"Language",
        "chapter":2,
        "name":"Teacher name",
        "rout" : Test(),
      },
    ];


    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        elevation: 0.0,
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
            child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: (MediaQuery.of(context).size.width)*0.4,
              childAspectRatio: 0.6,
              crossAxisSpacing:5,
            ),
              itemCount: Subjectdata.length,
                itemBuilder: (BuildContext ctx, index) {
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
                                  image: AssetImage(Subjectdata[index]['imageurl']),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                          Container(
                            width: 130,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Subjectdata[index]['language'] , style: AppTextStyle.subject,),
                                  SizedBox(width: 12,),
                                  Text((Subjectdata[index]['chapter']).toString() , style: AppTextStyle.chap,),
                                ],
                              ),
                              subtitle: Text(Subjectdata[index]['name'] , style: AppTextStyle.subtextgrey,),
                            ),
                          ),
                        ],
                      ) ,
                      onTap: (){
                        Navigator.push(
                          ctx,
                          MaterialPageRoute(builder: (context) => Subjectdata[index]['rout']),
                        );
                      },
                    );
                  }
            ),
          )
      ),
    );
  }


}

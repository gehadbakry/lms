import 'package:flutter/material.dart';
import 'package:lms_pro/app_style.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSet.whiteColor,
      width: MediaQuery.of(context).size.width*0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/teacher.png'),
                  radius: 25.0,
                ),
                title: Text("Teacher's name"),
              ),
              Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: Divider(height: 8,thickness: 1,)),
            ],
          );
        }),
      ),
    );
  }
}

class container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
              color: ColorSet.primaryColor,
              height: MediaQuery.of(context).size.height*0.05,
              child: Center(child: Text("Your teachers",style: AppTextStyle.headerStyle,) ,),
            );
  }
}

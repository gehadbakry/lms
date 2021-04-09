import 'package:flutter/material.dart';
import 'package:lms_pro/app_style.dart';

class Bus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height*0.65,
        child: Column(
          children: [
            ListTile(leading: Icon(Icons.directions_bus_rounded ,color: ColorSet.primaryColor,),
            title: Text("My Bus" ,  style: AppTextStyle.headerStyle2,),
              trailing: IconButton(icon: Icon(Icons.cancel_outlined,color: ColorSet.SecondaryColor,),
              onPressed: () {
                Navigator.of(context).pop();
              },
              ),
            ),
            SizedBox(height: 15,),
            SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bus Id\nص و 275"),
                        SizedBox(width: 10,),
                        VerticalDivider(color: Colors.grey,width: 1,thickness: 1,endIndent: 0.5,),
                        SizedBox(width: 10,),
                        Text("From\n8:00 Am"),
                        SizedBox(width: 10,),
                        VerticalDivider(color: Colors.grey,width: 1,thickness: 1,endIndent: 0.5),
                        SizedBox(width: 10,),
                        Text("To\n5:00 pm"),
                      ],
                    ),
                  ),
                  Divider(thickness: 1,),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_pin_rounded,color: ColorSet.primaryColor,),
                     title: Text("Driver" ,  style: AppTextStyle.headerStyle2,),
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: Image(image: AssetImage('assets/images/driver.png'),),
                            title: Text("Name:",style: AppTextStyle.leadtextstyle,),
                            subtitle: Text("phone:",style: AppTextStyle.leadtextstyle,),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text("complaint",style: AppTextStyle.complaint,),
                            onTap:(){} ,
                          ),
                          IconButton(icon: Icon(Icons.phone,color: ColorSet.SecondaryColor,size: 20,), onPressed: (){}),
                          IconButton(icon: Icon(Icons.file_copy,color: ColorSet.SecondaryColor,size: 20), onPressed: (){}),
                        ],
                      ),
                    ],
                  ),
                  Divider(thickness: 1,),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_pin_rounded,color: ColorSet.primaryColor,),
                        title: Text("Supervisor" ,  style: AppTextStyle.headerStyle2,),
                      ),
                      Container(
                        height: 95,
                        child: ListTile(
                          leading: Image(image: AssetImage('assets/images/businesswoman.png'),),
                          title: Text("Name:",style: AppTextStyle.leadtextstyle,),
                          subtitle: Text("phone:",style: AppTextStyle.leadtextstyle,),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text("complaint",style: AppTextStyle.complaint,),
                            onTap:(){} ,
                          ),
                          IconButton(icon: Icon(Icons.phone,color: ColorSet.SecondaryColor,size: 20,), onPressed: (){}),
                          IconButton(icon: Icon(Icons.file_copy,color: ColorSet.SecondaryColor,size: 20), onPressed: (){}),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
import 'package:flutter/material.dart';

import '../app_style.dart';

class NotifiNext extends StatefulWidget {
  @override
  _NotifiNextState createState() => _NotifiNextState();
}

class _NotifiNextState extends State<NotifiNext> {
  @override

  String mainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud";
  Widget build(BuildContext context) {
    Widget MyAppBar = AppBar(
      backgroundColor: ColorSet.primaryColor,
      elevation: 0.9,
      leading: IconButton(icon:Icon(Icons.arrow_back),  color: ColorSet.whiteColor,
          iconSize: 25,
          onPressed: (){
             Navigator.pop(
               context,
            //   MaterialPageRoute(builder: (context) => BNV()),
            );
          }) ,
      centerTitle: true,
      title: Text("Notifi Name", style:AppTextStyle.headerStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      ),
    );


    return Scaffold(
      appBar: MyAppBar,
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context , index){
            return Padding(
              padding: const EdgeInsets.only(left: 15 , right: 15 ,top: 10),
              child: Card(
                shadowColor: ColorSet.shadowcolour,
                elevation: 9.0,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorSet.borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LayoutBuilder(builder:(context , constraints){
                  return ListTile(
                    title: Text("Notifi Name" , style: AppTextStyle.textstyle20,),
                    trailing: Column(
                      children: [
                        Text("10/10/10" , style: AppTextStyle.subText,),
                        SizedBox(height: 20,),
                        Text("See more" , style: AppTextStyle.subText,),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top:10 , bottom: 10),
                      child: Text(mainText,
                        style: AppTextStyle.textstyle15,
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    onTap:() => alertDialog(context),
                  );
                } ,
                ),
              ),
            );
          }),
    );
  }
  void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: ListTile(
          leading:Text("Notifi Name" , style: AppTextStyle.textstyle20,),
        trailing: IconButton(
          icon: Icon(
            Icons.cancel_outlined,
            color: ColorSet.SecondaryColor,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      content: Text(mainText,style: AppTextStyle.textstyle15,),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0),
      ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

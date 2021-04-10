import 'package:flutter/material.dart';
import 'package:lms_pro/app_style.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/user.dart';
import 'choose_student.dart';
import 'dart:convert';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final _formKey = GlobalKey<FormState>();
  //Controlers to access data in the text field
  TextEditingController username ;
  var password = TextEditingController();

  Future<User> GUser;
  String url = 'jsonplaceholder.typicode.com';

  //FETCHIING YOUR DATA
  Future<User> getuser() async {
    http.Response MyUser = await http.get(Uri.https(url, 'users/1'));
    if (MyUser.statusCode == 200) {
      // print(MyUser.body);
      return User.fromJson(json.decode(MyUser.body));
    } else {
      throw Exception("can't get data");
    }
  }

  @override
  void initState() {
    GUser = getuser();
    username = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var newWidth =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;
    bool isvisible = true;

    return Scaffold(
      backgroundColor: ColorSet.whiteColor,
      body: Stack(
        children: [
          //Circle in the background
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
            child: Container(
              width: newWidth * 0.8,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 90),
                    child:Column(
                      children: [
                        //School logo
                        Container(
                          height: 118,
                          width: 284,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo2.jpeg'),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        //Form fields
                        //user name
                        TextFormField(
                          controller: username,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'Please enter your user name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Icon(
                                Icons.person, color: ColorSet.primaryColor,
                                size: 35.0,),
                            ), hintText: " User name",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorSet.borderColor),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        //password
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Icon(Icons.lock, color: ColorSet.primaryColor,
                                size: 35.0,),
                            ), hintText: " Password",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorSet.borderColor),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility , color: ColorSet.inactiveColor,),
                              onPressed: (){},
                            ),
                          ),
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isvisible,
                        ),
                        SizedBox(height: 25.0,),
                        //Language
                        TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(icon: Icon(Icons.arrow_drop_down,size: 35,color: ColorSet.inactiveColor,),
                                onPressed: (){
                                  return ExpansionTile(
                                    title: Text("Chosse your language" , style: TextStyle(color: ColorSet.inactiveColor),),
                                    children: [
                                      ListTile(leading: Text("English"),onTap: (){},),
                                      ListTile(leading: Text("Arabic"),onTap: (){},),
                                    ],
                                  );
                                },
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.public, color: ColorSet.primaryColor,
                                  size: 35.0,),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorSet.borderColor),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            )),
                        SizedBox(height: 35.0,),
                        //Log in button
                        Container(
                          width: newWidth*0.5,
                          child:FutureBuilder <User>(
                            future: GUser,
                            builder: (context , snapshot){
                              if(snapshot.hasData){
                                print(snapshot.data.Id);
                                print(snapshot.data.UserName);
                                return ElevatedButton(onPressed: ()async{
               //                   if(username == snapshot.data.UserName){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChooseStudent()),
                                  );
                                // }else{
                                //     print("Enter valid data");
                                //   }
                                  },
                                  child: Text("Log In",
                                    style: TextStyle(color: ColorSet.primaryColor),),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorSet.whiteColor,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                  ),);
                              }
                              else{
                                print("No Data");
                                return null;
                              }
                              return CircularProgressIndicator();
                            },
                          ) ,
                        ),
                        SizedBox(height: 25.0,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

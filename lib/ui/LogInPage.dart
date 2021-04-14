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
  String username = '';
  String password = '';
  String error = '';
  TextEditingController userid = TextEditingController();
/////Dropdown list data
  int _counter = 0;
  String dropDownValue;
  List<String> Language = [
    'Arabic',
    'English',
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  setFilters() {
    setState(() {
      dropDownValue = Language[0];
    });
  }

  //////Fetching data variables and functions
  Future<User> gUser;
  //FETCHIING YOUR DATA
  Future<User> getuser() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    http.Response MyUser = await http.get(url);
    if (MyUser.statusCode == 200) {
     // print(MyUser.body);
      return User.fromJson(json.decode(MyUser.body));
    } else {
      throw Exception("can't get data");
    }
  }

  @override
  void initState() {
    gUser = getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var newWidth =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;
    bool isvisible = true;
    //////page design and functions
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
                      child: Column(
                        children: [
                          //School logo
                          Container(
                            height: 118,
                            width: 284,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo2.jpeg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          //Form fields
                          //user name
                          TextFormField(
                            controller: userid,
                            validator: (val) =>
                            val.isEmpty ? "Enter your user Name" : null,
                            onChanged: (val) {
                              setState(() {
                                val = username;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.person,
                                  color: ColorSet.primaryColor,
                                  size: 35.0,
                                ),
                              ),
                              hintText: " User name",
                              border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: ColorSet.borderColor),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          //password
                          TextFormField(
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter some text';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.lock,
                                  color: ColorSet.primaryColor,
                                  size: 35.0,
                                ),
                              ),
                              hintText: " Password",
                              border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: ColorSet.borderColor),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: ColorSet.inactiveColor,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            //controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isvisible,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          //Language
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(24.0),
                                ),
                              ),
                              hintText: "Choose your language",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Icon(Icons.public_rounded,color: ColorSet.primaryColor,size: 35,),
                              ),
                            ),
                            value: dropDownValue,
                            //change route according to language
                            onChanged: (String Value) {
                              setState(() {
                                dropDownValue = Value;
                              });
                            },
                            items: Language.map((index) => DropdownMenuItem(
                                value: index, child: Text("$index"))).toList(),
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          //Log in button
                          Container(
                            width: newWidth * 0.5,
                            child: FutureBuilder<User>(future:gUser,
                              builder: (context, snapshot){
                              if(snapshot.hasData){
                                return ElevatedButton(
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(color: ColorSet.primaryColor),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorSet.whiteColor,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: (){
                                    // print(snapshot.data.Id);
                                    // print(snapshot.data.UserName);
                                    // print(snapshot.data.title);
                                    if(_formKey.currentState.validate() ){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChooseStudent()),
                                      );
                                    }
                                    else{
                                      print("didn't match");
                                    }
                                  },
                                );
                              }else if(snapshot.hasError){
                                print("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
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

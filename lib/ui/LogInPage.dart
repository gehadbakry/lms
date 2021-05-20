import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/api_services/student_data.dart';
import 'package:lms_pro/app_style.dart';
import 'package:http/http.dart' as http;
import 'package:lms_pro/models/Student.dart';
import 'package:lms_pro/models/login_model.dart';
import 'package:lms_pro/utils/ButtomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:lms_pro/ui/Home.dart';
import '../ProgressHUD.dart';
import 'choose_student.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String error = '';
  bool hidePassword = true;
  bool isApiCallProcess = false;
  LoginRequestModel loginRequestModel;
  LoginResponseModel loginResponseModel;
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

  @override
  void initState() {
    super.initState();
    loginResponseModel = LoginResponseModel();
    loginRequestModel = new LoginRequestModel();
  }
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }
  Widget _uiSetup(BuildContext context) {
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
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: newWidth * 0.8,
              child: Form(
                key: globalFormKey,
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
                          onSaved: (input) =>
                              loginRequestModel.username = input,
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
                          onSaved: (input) =>
                              loginRequestModel.password = input,
                          validator: (input) => input.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
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
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: ColorSet.primaryColor,
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          //controller: password,
                          keyboardType: TextInputType.visiblePassword,
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
                              child: Icon(
                                Icons.public_rounded,
                                color: ColorSet.primaryColor,
                                size: 35,
                              ),
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
                          child: ElevatedButton(
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
                            onPressed: () {
                             // Provider.of<APIService>(context,listen: false).login(loginRequestModel);
                              if (validateAndSave()) {
                                print(loginRequestModel.toJson());
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                APIService apiService = new APIService();
                                Provider.of<APIService>(context,listen: false).login(loginRequestModel).then((value) {
                                //apiService.login(loginRequestModel).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                  }
                                  if(Provider.of<APIService>(context,listen: false).usertype =='-1'){
                                  //if(apiService.usertype =='-1'){
                                    Toast.show("Account is invalid", context,
                                      duration:Toast.LENGTH_LONG,);
                                  }
                                  else if(Provider.of<APIService>(context,listen: false).usertype == '0'){
                                    Toast.show("Account is inactive", context,
                                      duration:Toast.LENGTH_LONG,);
                                  }
                                  else if(Provider.of<APIService>(context,listen: false).usertype == '4' ||(Provider.of<APIService>(context,listen: false).usertype == '3'&& Provider.of<APIService>(context,listen: false).children!= "") ){
                                      Navigator.pushNamed(context, '/choose',);
                                  }

                                  else if(Provider.of<APIService>(context,listen: false).usertype == '2'&& Provider.of<APIService>(context,listen: false).children == ""){
                                    Navigator.pushNamed(context, '/BNV');
                                  }
                                  else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BNV(),
                                      ),
                                    );
                                  }
                                });//68,

                              }
                              else if(validateAndSave() == false){
                                Toast.show("Either user or password is wrong", context,
                                  duration:Toast.LENGTH_LONG,);
                              }
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

  bool validateAndSave() {
    final _formKey = globalFormKey.currentState;
    if (_formKey.validate()) {
      _formKey.save();
      return true;
    }
    return false;
  }
}

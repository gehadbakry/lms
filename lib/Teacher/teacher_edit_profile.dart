import 'dart:io';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/teacher_api/getTeacherProfile.dart';
import 'package:lms_pro/teacher_models/teacher_profile_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../app_style.dart';

class TeacherEditProfile extends StatefulWidget {
  final code;
  final usercode;

  const TeacherEditProfile({Key key, this.code, this.usercode}) : super(key: key);

  @override
  _TeacherEditProfileState createState() => _TeacherEditProfileState();
}

class _TeacherEditProfileState extends State<TeacherEditProfile> {
  bool hidePassword = true;
  final picker = ImagePicker();
  TextEditingController Epassword = TextEditingController();
  TextEditingController EpasswordConfirm = TextEditingController();
  var imagepath='assets/images/teacher.png';
  File _image;
  Future getImagefromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImagefromcamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorSet.primaryColor,
        title: Text("Edit your Profile"),
        elevation: 0.0,
      ),
      body:Container(
    decoration: BoxDecoration(
    color: ColorSet.whiteColor,
    borderRadius:BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15) ),
    ),
        child: Column(
    children: [
        Padding(
        padding: const EdgeInsets.only(top: 35),
          child: FutureBuilder<List<TeacherModel>>(
              future: TeacherProfileInfo().getTeacherProfileInfo(widget.code),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          Container(
                            child: _image == null
                                ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: HttpStatus
                                          .internalServerError !=
                                          500
                                          ?NetworkImage(
                                          'http://169.239.39.105/LMS_site_demo/Home/GetImg?path=${snapshot.data[0].image}')
                                          :AssetImage(imagepath),
                                    )
                                )
                            )
                                : ClipOval(child: Image.file(_image)),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                            ),
                            height: 120,
                            width: 120,
                          ),
                          Positioned(
                            left: 85,
                            top: 1,
                            child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: Colors.grey.shade400,
                                  // borderRadius: BorderRadius.circular(10),
                                  shape:BoxShape.circle,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(Icons.camera_alt_outlined,color: ColorSet.whiteColor,size: 25,),
                                )
                            ),
                          ),
                        ],
                      ),
                      onTap: () => alertDialog(),
                    ),
                  ],
                );
                } else if (snapshot.hasError) {
                  return Text("error");
                }
                return Center(child: CircularProgressIndicator());
              }),
        ),
      Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 5,right: 40,left: 40),
        child: TextField(
          obscureText: hidePassword,
          controller: Epassword,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorSet.primaryColor),
            ),
            prefixIcon: IconButton(
              iconSize: 30,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.grey.shade400,
              icon: Icon(hidePassword
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            hintText: " New password",
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 5,right: 40,left: 40),
        child: TextField(
          controller: EpasswordConfirm,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorSet.primaryColor),
            ),
            prefixIcon: IconButton(
              iconSize: 30,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.grey.shade400,
              icon: Icon(hidePassword
                  ? Icons.check
                  : Icons.check),
            ),
            hintText: " Confirm your new password",
          ),
        ),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(right: 50,left:50,bottom: 30),
        child: ElevatedButton(onPressed: (){
          if(Epassword.text==EpasswordConfirm.text && (Epassword.text != null || Epassword.text != '') ){
            save(Epassword.text,_image==null?'': _image.path);
          }
          else  if(Epassword.text!=EpasswordConfirm.text){
            Toast.show("Passwords don't match", context,duration: Toast.LENGTH_LONG,gravity:Toast.CENTER );
          }
        }, child: Text('Save'),style:ElevatedButton.styleFrom(
            primary:ColorSet.SecondaryColor
        )),
      ),
    ]
        ),
      )
    );
  }
  alertDialog(){
    var alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: getImagefromcamera, icon: Icon(Icons.camera),color: ColorSet.primaryColor,iconSize: 35,),
              Text("Camera",style: TextStyle(fontSize: 15,color: ColorSet.primaryColor),)
            ],
          ),
          SizedBox(width: 40,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: getImagefromGallery, icon: Icon(Icons.image_rounded),color: ColorSet.primaryColor,iconSize: 35,),
              Text("Gallery",style: TextStyle(fontSize: 15,color: ColorSet.primaryColor))
            ],
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
  save(String password , String filepath) async {
    print(filepath.split('/').last);
    var uri =  Uri.parse("http://169.239.39.105/lms_api2/API/LoginApi/PostUserEditPeofile");

    var request = http.MultipartRequest('POST', uri)
      ..fields['user_code'] = Provider.of<APIService>(context, listen: false).usercode;
    request.fields['password'] = password;
    request.fields['facebook_url']='';
    request.fields['twitter_url']='';
    request.fields['instagram_url']='';
    request.fields['linkin_url']='';
    //request.files.add(await http.MultipartFile.fromPath('file',_image.path));

    _image == null?request.fields['file']= '':request.files.add(await http.MultipartFile.fromPath('file',filepath));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    if (response.statusCode == 200) {
      Toast.show("Your password was changed",context,duration:Toast.LENGTH_LONG);
      print("success");
    }
    else{
      print(response.statusCode);
      print("failed");
    }
    ;
  }

}

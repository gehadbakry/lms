import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_pro/api_services/api_service.dart';
import 'package:lms_pro/models/subject.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
class BuildMaterialPage extends StatefulWidget {
  @override
  _BuildMaterialPageState createState() => _BuildMaterialPageState();
}

class _BuildMaterialPageState extends State<BuildMaterialPage> {
  Subject subject;
  var code;
  String dropDownValue;
  List<String> Language = [
    'Arabic',
    'English',
  ];
  void initState() {
    subject = Subject();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context).settings.arguments;
    setState(() {
      code = Provider.of<APIService>(context, listen: false).code;
    });
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(15.0),
                    ),
                  ),
                  hintText: "Choose your language",
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
            ],
          ),
        ),
      ),
    );
  }
}

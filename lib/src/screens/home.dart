import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/src/services/provider.dart';

import 'package:school/src/widgets/custom_dropdown2.dart';

// import '../widgets/custom_animated_overlay.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Overlay test',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (_, i) {
            return Column(
              children: [
                BuildMaterialPage(),
                Consumer<ProvOne>(builder: (context, proveone, child) {
                  return proveone.pushPush
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 50,
                          height: proveone.heightPush,
                        )
                      : Container();
                }),
                Consumer<ProvTwo>(builder: (context, proveone, child) {
                  return proveone.pushPush
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 50,
                          height: proveone.heightPush,
                        )
                      : Container();
                }),
                BuildMaterialPage(),
                BuildMaterialPage(),
              ],
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';

class CustomAnimatedOverlay extends StatefulWidget {
  // Function pushOverlay;
  // CustomAnimatedOverlay({
  //   this.pushOverlay,
  // });
  @override
  CustomAnimatedOverlayState createState() => CustomAnimatedOverlayState();
}

class CustomAnimatedOverlayState extends State<CustomAnimatedOverlay> {
  static GlobalKey<CustomAnimatedOverlayState> CustomAnimatedOverlayKey =
      GlobalKey();
  double height;
  double loginWidth = 0.0;
  double _width = 0;
  pushOverlay() {
    setState(() {
      loginWidth = 255.0;
    });
  }

  pullOverlay() {
    setState(() {
      loginWidth = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // RenderBox renderBox = context.findRenderObject();
    // _height = renderBox.size.height;
    // width = renderBox.size.width;

    return AnimatedContainer(
      key: CustomAnimatedOverlayKey,
      duration: Duration(seconds: 1),
      width: _width / 1.4,
      height: 0,
      color: Colors.red,
    );
  }
}

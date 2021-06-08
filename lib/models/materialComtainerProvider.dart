import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProvOne with ChangeNotifier {
  bool pushPush = false;
  double heightPush = 0.0;
  doSomeThing(bool input, double height) {
    pushPush = input;
    heightPush = height;
    notifyListeners();
  }
}

class ProvTwo with ChangeNotifier {
  bool pushPush = false;
  double heightPush = 0.0;
  doSomeThing(bool input, double height) {
    pushPush = input;
    heightPush = height;
    notifyListeners();
  }
}
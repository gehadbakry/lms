import 'package:flutter/material.dart';
import '../../src/screens/test.dart';
import '../../src/routes/routes_names.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case testRoute:
        return MaterialPageRoute(builder: (_) => Test());
        break;
    }
  }
}

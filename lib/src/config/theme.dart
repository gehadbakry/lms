import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: textTheme(),
    accentColorBrightness: Brightness.dark,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline4: TextStyle(
      // fontFamily: 'OriginalSurfer',
      color: primaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/src/routes/custom_route.dart';

import 'src/config/theme.dart';
import 'src/screens/home.dart';
import 'src/services/provider.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProvOne>(
          create: (context) => ProvOne(),
        ),
        ChangeNotifierProvider<ProvTwo>(
          create: (context) => ProvTwo(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Demo',
        theme: theme(),
        home: MyHomePage(),
        onGenerateRoute: CustomRoute.allRoutes,
        navigatorObservers: [routeObserver],
      ),
    );
  }
}

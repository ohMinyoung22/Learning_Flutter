import 'package:flutter/material.dart';
import 'package:navigation/screen/route_one.dart';
import 'package:navigation/screen/route_three.dart';
import 'package:navigation/screen/route_two.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      //home: HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/one': (_) => RouteOneScreen(),
        '/two': (_) => RouteTwoScreen(),
        '/three': (_) => RouteThreeScreen(),
      },
    ),
  );
}

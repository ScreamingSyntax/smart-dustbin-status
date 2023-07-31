import 'package:flutter/material.dart';
import 'package:smart_dustbin/screens/check_screen.dart';
import 'package:smart_dustbin/screens/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      // return MaterialPageRoute(builder: (context) => CheckScreen());

      default:
        return null;
    }
  }
}

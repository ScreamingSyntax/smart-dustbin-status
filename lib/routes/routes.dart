import 'package:flutter/material.dart';
import 'package:smart_dustbin/screens/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return null;
    }
  }
}

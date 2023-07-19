import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smart_dustbin/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AppRouter _router = AppRouter();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}

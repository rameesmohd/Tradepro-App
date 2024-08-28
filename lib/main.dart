import 'package:flutter/material.dart';
import 'package:tradepro/app/splash/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trade Pro',
      theme: ThemeData(
        fontFamily: 'Poppins',

        // Customize text styles if needed
        // textTheme: TextTheme(
        //   bod: TextStyle(fontSize: 16.0),
        //   bodyText2: TextStyle(fontSize: 14.0),
        //   headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        //   // Add more text styles as needed
        // ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScreenSplashView(),
    );
  }
}

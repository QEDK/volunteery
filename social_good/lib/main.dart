import 'package:flutter/material.dart';
import 'package:social_good/pages/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // the main here will have a 'splash' as home-screen and other pages routes
    // TODO: add a gesture detector for keyboard consistency and a Mutliprovider later on!
    return MaterialApp(
      title: 'Social Good',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {},
    );
  }
}

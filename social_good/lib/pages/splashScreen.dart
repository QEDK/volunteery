import 'package:flutter/material.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          color: MyColors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image(
                image: AssetImage('assets/icons/hands.png'),
                fit: BoxFit.cover,
              )),
              MySpaces.vSmallGapInBetween,
              Text(MyStrings.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: MyColors.accentColor, fontFamily: 'danceb')),
            ],
          ),
        ),
      ),
    );
  }
}

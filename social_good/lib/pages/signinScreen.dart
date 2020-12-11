import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/stores/loginStore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_good/widgets/signinButton.dart';

class SignInScreen extends StatefulWidget {
  static String id = "sign_in_screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginStore>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: MyColors.white,
          padding: EdgeInsets.symmetric(
              horizontal: MyDimens.double_25, vertical: MyDimens.double_100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    MyStrings.greeting,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        color: MyColors.accentColor, fontFamily: 'airbnb'),
                  ),
                  Text(
                    MyStrings.dot,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        color: MyColors.primaryColor, fontFamily: 'airbnb'),
                  ),
                ],
              ),
              MySpaces.vLargeGapInBetween,
              MySpaces.vLargeGapInBetween,
              SignInButton(color: MyColors.yellowLight, label: MyStrings.volunteer, type: "Volunteer",),
              MySpaces.vSmallGapInBetween,
              SignInButton(color: MyColors.orangeLight, label: MyStrings.organisation, type: "Organisation",),
            ],
          ),
        ),
      ),
    );
  }
}

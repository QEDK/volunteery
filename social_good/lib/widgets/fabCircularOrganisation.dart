import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_good/functions/urlLauncher.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/pages/organisation/addEvent.dart';
import 'package:social_good/pages/signinScreen.dart';
import 'package:social_good/pages/volunteer/interestedEvents.dart';
import 'package:social_good/pages/volunteer/volunteerProfile.dart';
import 'package:social_good/stores/loginStore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FabCircularOrganisation extends StatefulWidget {
  @override
  _FabCircularOrganisationState createState() =>
      _FabCircularOrganisationState();
}

class _FabCircularOrganisationState extends State<FabCircularOrganisation> {
  final User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
        fabColor: MyColors.primaryColor,
        ringColor: MyColors.primaryColor,
        fabCloseIcon: Icon(Icons.close, color: MyColors.white),
        fabOpenIcon: Icon(Icons.menu, color: MyColors.white),
        fabMargin: EdgeInsets.all(MyDimens.double_15),
        ringWidth: MyDimens.double_100,
        children: <Widget>[
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: MyColors.white,
              ),
              onPressed: () {
                Provider.of<LoginStore>(context, listen: false).signOut();
                Navigator.pushNamed(context, SignInScreen.id);
              },
            ),
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.github, color: MyColors.white),
            onPressed: () {
              launchURL("https://github.com/QEDK/volunteery");
            },
          ),
          IconButton(
            icon: Icon(Icons.add_box, color: MyColors.white),
            onPressed: () {
              Navigator.pushNamed(context, AddEvent.id);
            },
          ),
        ]);
  }
}

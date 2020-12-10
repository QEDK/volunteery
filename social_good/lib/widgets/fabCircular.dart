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
import 'package:social_good/pages/signinScreen.dart';
import 'package:social_good/pages/volunteer/interestedEvents.dart';
import 'package:social_good/pages/volunteer/volunteerProfile.dart';
import 'package:social_good/stores/loginStore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FabCircular extends StatefulWidget {
  @override
  _FabCircularState createState() => _FabCircularState();
}

class _FabCircularState extends State<FabCircular> {
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
          IconButton(
            icon: Icon(Icons.search, color: MyColors.white),
            onPressed: () {},
          ),
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
            icon: Icon(Icons.list_alt, color: MyColors.white),
            onPressed: () {
              Navigator.pushNamed(context, InterestedEvents.id);
            },
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Volunteer')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitChasingDots(
                    color: MyColors.white,
                    size: 20,
                  ));
                } else {
                  // Address, DOB, Gender, Mobile, Name
                  List<String> volunteerInfo = new List<String>(5);
                  String uid = currentUser.uid;
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    if (snapshot.data.documents[i].documentID == uid) {
                      volunteerInfo[0] =
                          snapshot.data.docs[i].data()['address'];
                      volunteerInfo[1] = snapshot.data.docs[i].data()['dob'];
                      volunteerInfo[2] = snapshot.data.docs[i].data()['gender'];
                      volunteerInfo[3] = snapshot.data.docs[i].data()['mobile'];
                      volunteerInfo[4] = snapshot.data.docs[i].data()['name'];
                    }
                  }
                  print(volunteerInfo);
                  return IconButton(
                    icon: Icon(Icons.person_outline, color: MyColors.white),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              VolunteerProfile(volunteerInfo: volunteerInfo)));
                    },
                  );
                }
              }),
        ]);
  }
}

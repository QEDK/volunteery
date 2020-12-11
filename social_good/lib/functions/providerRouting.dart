import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_good/pages/signinScreen.dart';
import 'package:social_good/pages/splashScreen.dart';
import 'package:social_good/pages/volunteer/volunteerForm.dart';
import 'package:social_good/pages/volunteer/volunteerHomeScreen.dart';
import 'package:social_good/stores/loginStore.dart';

class ProviderRouting extends StatelessWidget {

  // TODO: Correct this function in some way to help surpass the profile editing while logging in everytime
  void _decideUserRole(LoginStore user, BuildContext context) async{
    User firebaseUser = FirebaseAuth.instance.currentUser;
    var collectionRef = FirebaseFirestore.instance.collection('Volunteer');
    var doc = await collectionRef.doc(firebaseUser.uid).get();
    if(doc.exists)
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>  VolunteerHomeScreen(currentUser: user.user)), (Route<dynamic> route) => false);
    else
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>  VolunteerForm(currentUser: user.user)), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginStore.instance(),
      child: Consumer(
        // ignore: missing_return
        builder: (context, LoginStore user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return SplashScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return SignInScreen();
            case Status.Authenticated:
              return VolunteerForm(currentUser: user.user);
          }
        },
      ),
    );
  }
}
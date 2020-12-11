import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_good/functions/providerRouting.dart';
import 'package:social_good/pages/organisation/addEvent.dart';
import 'package:social_good/pages/organisation/organisationEvents.dart';
import 'package:social_good/pages/organisation/organisationForm.dart';
import 'package:social_good/pages/signinScreen.dart';
import 'package:social_good/pages/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:social_good/pages/volunteer/eventDesciption.dart';
import 'package:social_good/pages/volunteer/interestedEvents.dart';
import 'package:social_good/pages/volunteer/volunteerForm.dart';
import 'package:social_good/pages/volunteer/volunteerHomeScreen.dart';
import 'package:social_good/pages/volunteer/volunteerProfile.dart';
import 'package:social_good/stores/loginStore.dart';
import 'globals/myColors.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
            return SpinKitChasingDots(color: MyColors.primaryColor,);
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
      },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // the main here will have a 'splash' as home-screen and other pages routes
    // TODO: add a gesture detector for keyboard consistency
    // TODO: add a ProviderRouting --done!
    return MultiProvider(
      providers: [
        InheritedProvider<LoginStore>(
          create: (_) => LoginStore.instance(),
        )
      ],
      child: MaterialApp(
        title: 'Volunteery',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: ProviderRouting(),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          VolunteerForm.id: (context) => VolunteerForm(),
          OrganisationForm.id: (context) => OrganisationForm(),
          VolunteerHomeScreen.id: (context) => VolunteerHomeScreen(),
          EventDescription.id: (context) => EventDescription(),
          VolunteerProfile.id: (context) => VolunteerProfile(),
          InterestedEvents.id: (context) => InterestedEvents(),
          AddEvent.id:(context) => AddEvent(),
          OrganisationEvents.id:(context) => OrganisationEvents(),
        },
      ),
    );
  }
}

// TODO: Remove this UserInfoPage after making the volunteer home page -- done


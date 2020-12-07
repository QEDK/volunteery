import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_good/functions/providerRouting.dart';
import 'package:social_good/pages/signinScreen.dart';
import 'package:social_good/pages/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:social_good/stores/loginStore.dart';

import 'globals/myColors.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
    return MaterialApp(
      title: 'Social Good',
      debugShowCheckedModeBanner: false,
      home: ProviderRouting(),
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SignInScreen.id: (context) => SignInScreen(),
      },
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            Text(user.displayName),
            Text(user.uid),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () => Provider.of<LoginStore>(context, listen: false).signOut(),
            )
          ],
        ),
      ),
    );
  }
}


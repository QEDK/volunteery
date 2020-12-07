import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_good/pages/signinScreen.dart';
import 'package:social_good/pages/splashScreen.dart';
import 'package:social_good/stores/loginStore.dart';
import '../main.dart';

class ProviderRouting extends StatelessWidget {
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
              return UserInfoPage(user: user.user);
          }
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/stores/loginStore.dart';

class SignInButton extends StatefulWidget {
  final Color color;
  final String label;
  final String type;

  SignInButton({@required this.color, this.label, this.type});

  @override
  _SignInButtonState createState() => _SignInButtonState(color,label,type);
}

class _SignInButtonState extends State<SignInButton> {
  Color color;
  String label;
  String type;
  _SignInButtonState(this.color,this.label, this.type);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginStore>(context);
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            onPressed: () async {
              if (!await user.signInWithGoogle(type)) {
                final snackBar = SnackBar(
                  content: Text(MyStrings.snackBarMessage),
                );
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(snackBar);
                print('Something is wrong!');
              }
            },
            padding: EdgeInsets.all(MyDimens.double_15),
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MyDimens.double_30)),
            child: Padding(
              padding: const EdgeInsets.only(left: MyDimens.double_15),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/icons/google.png'),
                    height: MyDimens.double_20,
                    width: MyDimens.double_20,
                  ),
                  MySpaces.hSmallGapInBetween,
                  Text(
                    label,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: MyColors.accentColor, fontFamily: 'airbnb'),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

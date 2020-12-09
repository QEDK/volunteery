import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';

class FabCircular extends StatefulWidget {
  @override
  _FabCircularState createState() => _FabCircularState();
}

class _FabCircularState extends State<FabCircular> {
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
            icon: FaIcon(FontAwesomeIcons.github, color: MyColors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search, color: MyColors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.list_alt, color: MyColors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: MyColors.white),
            onPressed: () {},
          ),
        ]);
  }
}

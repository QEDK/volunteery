import 'package:flutter/material.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/widgets/accordion.dart';
import 'package:social_good/widgets/fabCircular.dart';

class InterestedEvents extends StatefulWidget {
  static String id = "interested_events";

  @override
  _InterestedEventsState createState() => _InterestedEventsState();
}

class _InterestedEventsState extends State<InterestedEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: MyColors.white,
              size: MyDimens.double_15,
            )),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.sort,
                color: MyColors.white,
              )),
          MySpaces.hMediumGapInBetween,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Material(
            color: MyColors.accentColor,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyDimens.double_20,
                      vertical: MyDimens.double_20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyStrings.interested,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: MyColors.white, fontFamily: 'airbnb')),
                      MySpaces.hSmallestGapInBetween,
                      Text(MyStrings.events,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: MyColors.white, fontFamily: 'lexen')),
                    ],
                  ),
                ),
                Positioned(
                  top: MyDimens.double_100,
                  child: Container(
                    padding: EdgeInsets.only(top: MyDimens.double_70),
                    height: MyDimens.double_600,
                    width: MyDimens.double_600,
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(MyDimens.double_60),
                    ),
                  ),
                ),
                MyAccordionWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircular(),
      ),
    );
  }
}

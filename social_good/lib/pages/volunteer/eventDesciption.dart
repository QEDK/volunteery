import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/widgets/fabCircular.dart';

class EventDescription extends StatefulWidget {
  static String id = "event_description";

  final User currentUser;

  const EventDescription({Key key, @required this.currentUser})
      : super(key: key);

  @override
  _EventDescriptionState createState() => _EventDescriptionState(currentUser);
}

class _EventDescriptionState extends State<EventDescription> {
  final User currentUser;

  _EventDescriptionState(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          MyStrings.eventName,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: MyColors.accentColor, fontFamily: 'airbnb'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: MyColors.accentColor,
            )),
      ),
      body: SafeArea(
        child: Material(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MyDimens.double_15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Card(
                        elevation: MyDimens.double_10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(MyDimens.double_10)),
                        child: Image(
                          image: AssetImage('assets/images/beach.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  MySpaces.vSmallGapInBetween,
                  Text(
                    MyStrings.eventDate,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: MyColors.accentColorLight, fontFamily: 'lexen'),
                  ),
                  Text(
                    MyStrings.eventLocation,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: MyColors.accentColor, fontFamily: 'airbnb'),
                  ),
                  Text(
                    MyStrings.eventOrganisation,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: MyColors.accentColor, fontFamily: 'lexen'),
                  ),
                  MySpaces.vSmallestGapInBetween,
                  Text(
                    MyStrings.eventInformation,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: MyColors.accentColorLight, fontFamily: 'lexen'),
                  ),
                  MySpaces.vMediumGapInBetween,
                  Row(
                    children: [
                      Expanded(
                        child: OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          borderSide: BorderSide(color: MyColors.greenPrimary),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: MyColors.greenPrimary,
                              ),
                              MySpaces.hSmallestGapInBetween,
                              Text(
                                'Interested',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        color: MyColors.greenPrimary,
                                        fontFamily: 'lexen'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MySpaces.hMediumGapInBetween,
                      Expanded(
                        child: OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          borderSide: BorderSide(color: MyColors.redPrimary),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.times,
                                color: MyColors.redPrimary,
                              ),
                              MySpaces.hSmallestGapInBetween,
                              Text(
                                "I'm not in",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        color: MyColors.redPrimary,
                                        fontFamily: 'lexen'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  MySpaces.vLargeGapInBetween,
                  MySpaces.vLargeGapInBetween,
                ],
              ),
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

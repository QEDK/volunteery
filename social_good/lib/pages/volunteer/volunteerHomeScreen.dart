import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:social_good/widgets/fabCircularVolunteer.dart';

import 'eventDesciption.dart';

List<Color> _textColorDateTime = [MyColors.accentColor, MyColors.accentColor];
List<Color> _bodyColorDateTime = [MyColors.yellowPrimary, MyColors.white];

int _compIndex(int index) {
  if (index % 2 == 1)
    return index - 1;
  else
    return index + 1;
}

class VolunteerHomeScreen extends StatefulWidget {
  static String id = "volunteer_home_screen";
  final User currentUser;

  const VolunteerHomeScreen({Key key, @required this.currentUser})
      : super(key: key);

  _VolunteerHomeScreenState createState() =>
      _VolunteerHomeScreenState(currentUser);
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final User currentUser;

  _VolunteerHomeScreenState(this.currentUser);

  // TODO: Replace with data from Firebase -- done
  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: SafeArea(
        child: Material(
          child: Container(
            color: MyColors.white,
            child: Column(
              children: [
                Container(
                  height: MyDimens.double_30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      MyColors.primaryColor,
                      MyColors.yellowPrimary
                    ]),
                  ),
                ),
                // _switchDateTime(),
                MySpaces.vSmallGapInBetween,
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Event')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: SpinKitChasingDots(
                          color: MyColors.primaryColor,
                          size: 20,
                        ));
                      } else {
                        List<String> allImages = [
                          "assets/images/beach.jpg",
                          "assets/images/girl.jpeg",
                          "assets/images/tree.jpg",
                          "assets/images/blood.jpg",
                        ];

                        List<String> cardTitles = new List<String>();
                        List<String> cardDates = new List<String>();
                        List<String> cardLocations = new List<String>();
                        List<String> cardOrganisations = new List<String>();
                        List<String> cardImages = new List<String>();
                        List<String> eventUid = new List<String>();
                        for (int i = 0;
                            i < snapshot.data.documents.length;
                            i++) {
                          eventUid.add(snapshot.data.documents[i].documentID);
                          cardTitles.add(
                              snapshot.data.documents[i].data()['eventName']);
                          cardLocations.add(snapshot.data.documents[i]
                              .data()['eventAddress']);
                          cardOrganisations.add(
                              snapshot.data.documents[i].data()['orgName']);
                          cardDates.add(snapshot.data.documents[i]
                                  .data()['eventDate'] +
                              ' at ' +
                              snapshot.data.documents[i].data()['eventTime']);
                          Random random = new Random();
                          cardImages.add(allImages[random.nextInt(4)]);
                        }
                        print(eventUid);
                        print(cardTitles);
                        print(cardDates);
                        print(cardLocations);
                        print(cardOrganisations);
                        print(cardImages);

                        return Container(
                          height: MediaQuery.of(context).size.height * 0.83,
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MyDimens.double_25),
                                  child: Text(MyStrings.exhaust,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                              color: MyColors.accentColor,
                                              fontFamily: 'lexen')),
                                ),
                              ),
                              TinderSwapCard(
                                orientation: AmassOrientation.BOTTOM,
                                totalNum: cardImages.length,
                                stackNum: 2,
                                swipeEdge: 4.0,
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight: MediaQuery.of(context).size.height,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.9,
                                cardBuilder: (context, index) =>
                                    GestureDetector(
                                  onLongPress: () {
                                    // TODO: Implement Long Pressed -- done
                                    print('LongPressed');
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => EventDescription(
                                                eventUid: eventUid[index])));
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: MyDimens.double_5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            MyDimens.double_10)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              '${cardImages[index]}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          // TODO: Implement Desc Tap -- done
                                          print('Tap on description');
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => EventDescription(
                                                      eventUid: eventUid[index])));
                                        },
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black38.withOpacity(0.4),
                                              BlendMode.screen),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: MyDimens.double_7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${cardTitles[index]}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          color: MyColors.white,
                                                          fontFamily: 'airbnb'),
                                                ),
                                                Text(
                                                  '${cardDates[index]}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                          color: MyColors.white,
                                                          fontFamily: 'lexen'),
                                                ),
                                                Text(
                                                  '${cardLocations[index]}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          color: MyColors.white,
                                                          fontFamily: 'airbnb'),
                                                ),
                                                Text(
                                                  '${cardOrganisations[index]}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                          color: MyColors.white,
                                                          fontFamily: 'airbnb'),
                                                ),
                                                MySpaces.vLargeGapInBetween,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                cardController: controller = CardController(),
                                swipeUpdateCallback: (DragUpdateDetails details,
                                    Alignment align) {
                                  // Get swiping card's alignment
                                  if (align.x < 0) {
                                    // TODO: Implement LEFT SWIPE
                                  } else if (align.x > 0) {
                                    // TODO: Implement RIGHT SWIPE & Ask Shambhavi about the swiping thing -- done
                                    // TODO: Should we implement here?
                                    // Navigator.pushNamed(context, EventDescription.id);
                                  }
                                },
                                swipeCompleteCallback:
                                    (CardSwipeOrientation orientation,
                                        int index) {
                                  // Get orientation & index of swiped card!
                                  // TODO: Implement Post SWIPE stuff
                                  print(orientation.index);
                                  print(index);
                                  if (orientation.index == 1)
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => EventDescription(
                                                eventUid: eventUid[index])));
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularVolunteer(),
      ),
    );
  }

  Widget _getText(String text, Color color) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(color: color, fontFamily: 'airbnb'),
    );
  }

  Widget _switchDateTime() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MyDimens.double_10),
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(MyDimens.double_25)),
      child: Row(
        children: [
          _buttonsDateTime('Date', 0),
          _buttonsDateTime('Time', 1),
        ],
      ),
    );
  }

  Widget _buttonsDateTime(String text, int index) {
    return Expanded(
      child: RaisedButton(
        elevation: 0,
        color: _bodyColorDateTime[index],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MyDimens.double_25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  icon: (index == 0)
                      ? Icon(
                          Icons.calendar_today,
                          size: MyDimens.double_20,
                          color: MyColors.accentColor,
                        )
                      : Icon(
                          Icons.alarm,
                          size: MyDimens.double_20,
                          color: MyColors.accentColor,
                        ),
                  onPressed: () {}),
            ),
            _getText(text, _textColorDateTime[index]),
          ],
        ),
        onPressed: () {
          setState(() {
            if (_bodyColorDateTime[index] == MyColors.white) {
              _bodyColorDateTime[index] = MyColors.yellowPrimary;
              _textColorDateTime[index] = MyColors.accentColor;
              _bodyColorDateTime[_compIndex(index)] = MyColors.white;
              _textColorDateTime[_compIndex(index)] = MyColors.accentColor;
            }
          });
        },
      ),
    );
  }
}

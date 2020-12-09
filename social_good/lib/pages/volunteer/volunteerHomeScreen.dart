// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:social_good/stores/loginStore.dart';
//
// class VolunteerHomeScreen extends StatelessWidget {
//   static String id = "volunteer_home_screen";
//   final User currentUser;
//
//   const VolunteerHomeScreen({Key key, @required this.currentUser}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Info"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(currentUser.email),
//             Text(currentUser.displayName),
//             Text(currentUser.uid),
//             RaisedButton(
//                 child: Text("Sign Out"),
//                 onPressed: () {
//                   Provider.of<LoginStore>(context,listen: false).signOut();
//                   Navigator.pop(context);
//                 }
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:social_good/widgets/fabCircular.dart';

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

  // TODO: Replace with data from Firebase
  List<String> cardImages = [
    "assets/images/beach.jpg",
    "assets/images/girl.jpeg",
    "assets/images/tree.jpg",
    "assets/images/blood.jpg",
    "assets/images/beach.jpg",
    "assets/images/girl.jpeg",
    "assets/images/tree.jpg",
    "assets/images/blood.jpg",
  ];

  List<String> cardTitles = [
    "Beach Cleanup Drive",
    "Educate the Girl Child",
    "Plant a tree",
    "Blood Donation",
    "Beach Cleanup Drive",
    "Educate the Girl Child",
    "Plant a tree",
    "Blood Donation",
  ];

  List<String> cardDates = [
    "Dec 3, 2020 at 7:00 AM",
    "Dec 4, 2020 at 7:00 AM",
    "Dec 5, 2020 at 7:00 AM",
    "Dec 6, 2020 at 7:00 AM",
    "Dec 31, 2020 at 7:00 AM",
    "Dec 2, 2020 at 7:00 AM",
    "Dec 7, 2020 at 7:00 AM",
    "Dec 8, 2020 at 7:00 AM",
  ];

  List<String> cardLocations = [
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
    "Girgaon Chowpatty, Mumbai",
  ];

  List<String> cardOrganisations = [
    "Leo Multiple",
    "Women Empowerment Org",
    "Leo Multiple",
    "Leo Multiple",
    "Leo Multiple",
    "Leo Multiple",
    "Leo Multiple",
    "Leo Multiple",
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: SafeArea(
        child: Material(
          child: Container(
            color: MyColors.backgroundColor,
            child: Column(
              children: [
                MySpaces.vSmallestGapInBetween,
                _switchDateTime(),
                MySpaces.vSmallestGapInBetween,
                Container(
                  height: MediaQuery.of(context).size.height * 0.86,
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
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                        minHeight: MediaQuery.of(context).size.height * 0.9,
                        cardBuilder: (context, index) => GestureDetector(
                          onLongPress: () {
                            // TODO: Implement OnPressed
                            print('LongPressed');
                          },
                          child: Card(
                            elevation: MyDimens.double_5,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('${cardImages[index]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(Colors.black38.withOpacity(0.4), BlendMode.screen),
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: MyDimens.double_7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                        cardController: controller = CardController(),
                        swipeUpdateCallback:
                            (DragUpdateDetails details, Alignment align) {
                          // Get swiping card's alignment
                          if (align.x < 0) {
                            // TODO: Implement LEFT SWIPE
                          } else if (align.x > 0) {
                            // TODO: Implement RIGHT SWIPE
                          }
                        },
                        swipeCompleteCallback:
                            (CardSwipeOrientation orientation, int index) {
                          // Get orientation & index of swiped card!
                          // TODO: Implement Post SWIPE stuff
                          print(orientation.index);
                          print(index);
                        },
                      ),
                    ],
                  ),
                ),
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

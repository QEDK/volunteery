import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/pages/organisation/organisationEvents.dart';
import 'package:social_good/widgets/accordion.dart';
import 'package:social_good/widgets/fabCircularVolunteer.dart';

List<Item> generateItems(int numberOfItems, List<String> images,
    List<String> headers, List<String> descriptions, List<String> eventUid) {
  return List.generate(numberOfItems, (int index) {
    String img = images[index];
    String header = headers[index];
    String desc = descriptions[index];
    String uid = eventUid[index];
    return Item(
      id: index,
      eventUid: uid,
      headerValue: header,
      expandedValue: '$desc',
      imageUrl: 'assets/images/$img.jpg',
    );
  });
}

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
        backgroundColor: MyColors.primaryColor,
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
            color: MyColors.primaryColor,
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
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: MyColors.white, fontFamily: 'airbnb')),
                      MySpaces.hSmallestGapInBetween,
                      Text(MyStrings.events,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: MyColors.white, fontFamily: 'lexen')),
                    ],
                  ),
                ),
                Positioned(
                  top: MyDimens.double_100,
                  child: Container(
                    padding: EdgeInsets.only(top: MyDimens.double_70),
                    height: MyDimens.double_1000,
                    width: MyDimens.double_600,
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(MyDimens.double_60),
                    ),
                  ),
                ),
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
                          'beach',
                          'blood',
                          'beach',
                          'tree',
                        ];
                        User currentUser = FirebaseAuth.instance.currentUser;
                        String uid = currentUser.uid;

                        List<String> eventName = new List<String>();
                        List<String> eventDesc = new List<String>();
                        List<String> eventImg = new List<String>();
                        List<String> eventUid = new List<String>();
                        for (int i = 0;
                            i < snapshot.data.documents.length;
                            i++) {
                          // check if the user is a volunteer for the event
                          if (snapshot.data.documents[i]
                              .data()['volunteers']
                              .contains(uid)) {
                            eventName.add(
                                snapshot.data.documents[i].data()['eventName']);
                            eventDesc.add(snapshot.data.documents[i]
                                .data()['eventDescription']);
                            eventUid.add(snapshot.data.documents[i].documentID);
                            Random random = new Random();
                            eventImg.add(allImages[random.nextInt(4)]);
                          }
                        }
                        List<Item> data = generateItems(eventName.length,
                            eventImg, eventName, eventDesc, eventUid);
                        if (eventName.length == 0)
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.4,
                                horizontal: 20),
                            child: Text(
                                'You have not registered as a volunteer for any event yet. Register to see events here!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: MyColors.accentColor,
                                        fontFamily: 'lexen')),
                          );
                        return MyAccordionWidget(data: data, type: "Volunteer");
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/widgets/fabCircularVolunteer.dart';

class EventDescription extends StatefulWidget {
  static String id = "event_description";

  final String eventUid;

  const EventDescription({Key key, @required this.eventUid}) : super(key: key);

  @override
  _EventDescriptionState createState() => _EventDescriptionState(eventUid);
}

class _EventDescriptionState extends State<EventDescription> {
  final String eventUid;

  _EventDescriptionState(this.eventUid);

  // TODO: Add volunteers to firebase (update) -- done
  void _onPressedAddVolunteers(List<dynamic> volunteers, String uid) async {
    FirebaseFirestore.instance.collection('Event').doc(uid).update({
      'volunteers':volunteers,
    }).then((_) {
      print('added new volunteer details to FireStore');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Event').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: SpinKitChasingDots(
              color: MyColors.primaryColor,
              size: 20,
            ));
          } else {
            String eventName,
                eventDate,
                eventLocation,
                eventOrganisation,
                eventInformation;
            List<dynamic> volunteerList=new List<dynamic>();
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (snapshot.data.documents[i].documentID == eventUid) {
                eventName = snapshot.data.documents[i].data()['eventName'];
                eventDate = snapshot.data.documents[i].data()['eventDate'] +
                    ' at ' +
                    snapshot.data.documents[i].data()['eventTime'];
                eventLocation =
                    snapshot.data.documents[i].data()['eventAddress'];
                eventOrganisation =
                    'by ' + snapshot.data.documents[i].data()['orgName'];
                eventInformation =
                    snapshot.data.documents[i].data()['eventDescription'];
                volunteerList=snapshot.data.documents[i].data()['volunteers'];
              }
            }
            User currentUser=FirebaseAuth.instance.currentUser;
            volunteerList.add(currentUser.uid);
            volunteerList=volunteerList.toSet().toList(); // removes duplicates from the list!
            print(volunteerList);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  eventName,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: MyColors.accentColor, fontFamily: 'airbnb'),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: MyDimens.double_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Card(
                                elevation: MyDimens.double_10,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        MyDimens.double_10)),
                                child: Image(
                                  image: AssetImage('assets/images/beach.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          MySpaces.vSmallGapInBetween,
                          Text(
                            eventDate,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: MyColors.accentColorLight,
                                    fontFamily: 'lexen'),
                          ),
                          Text(
                            eventLocation,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: MyColors.accentColor,
                                    fontFamily: 'airbnb'),
                          ),
                          Text(
                            eventOrganisation,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: MyColors.accentColor,
                                    fontFamily: 'lexen'),
                          ),
                          MySpaces.vSmallestGapInBetween,
                          Text(
                            eventInformation,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: MyColors.accentColorLight,
                                    fontFamily: 'lexen'),
                          ),
                          MySpaces.vMediumGapInBetween,
                          Row(
                            children: [
                              Expanded(
                                child: OutlineButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  borderSide:
                                      BorderSide(color: MyColors.redPrimary),
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
                              MySpaces.hMediumGapInBetween,
                              Expanded(
                                child: OutlineButton(
                                  onPressed: () {
                                    _onPressedAddVolunteers(volunteerList, eventUid);
                                    Fluttertoast.showToast(msg:"You have successfully registered as a volunteer!");
                                    Navigator.pop(context);
                                  },
                                  borderSide:
                                      BorderSide(color: MyColors.greenPrimary),
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
                            ],
                          ),
                          MySpaces.vLargeGapInBetween,
                          MySpaces.vLargeGapInBetween,
                          MySpaces.vLargeGapInBetween,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButton: Builder(
                builder: (context) => FabCircularVolunteer(),
              ),
            );
          }
        });
  }
}

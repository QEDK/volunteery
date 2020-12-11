import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/widgets/fabCircularOrganisation.dart';
import 'package:social_good/widgets/fabCircularVolunteer.dart';

class OrgEventDesc extends StatefulWidget {
  static String id = "org_event_desc";

  final String eventUid;

  const OrgEventDesc({Key key, @required this.eventUid}) : super(key: key);

  @override
  _OrgEventDescState createState() => _OrgEventDescState(eventUid);
}

class _OrgEventDescState extends State<OrgEventDesc> {
  final String eventUid;

  _OrgEventDescState(this.eventUid);

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
            List<dynamic> volunteers = new List<dynamic>();
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
                volunteers = snapshot.data.documents[i].data()['volunteers'];
              }
            }
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
                          MySpaces.vLargeGapInBetween,
                          Text(
                            'Volunteers Registered',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: MyColors.accentColor,
                                    fontFamily: 'lexen'),
                          ),
                          MySpaces.vSmallGapInBetween,
                          for (int k = 0; k < volunteers.length; k++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Volunteer')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: SpinKitChasingDots(
                                        color: MyColors.primaryColor,
                                        size: 20,
                                      ));
                                    } else {
                                      String name,mobile, dob,address,gender;
                                      for (int i = 0;
                                          i < snapshot.data.documents.length;
                                          i++) {
                                        if (snapshot.data.documents[i]
                                                .documentID ==
                                            volunteers[k]) {
                                          name=snapshot.data.documents[i].data()['name'];
                                          mobile=snapshot.data.documents[i].data()['mobile'];
                                          dob=snapshot.data.documents[i].data()['dob'];
                                          address=snapshot.data.documents[i].data()['address'];
                                          gender=snapshot.data.documents[i].data()['gender'];
                                          break;
                                        }
                                      }
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.circle,size: 10,color: MyColors.accentColorLight,),
                                              MySpaces.hSmallestGapInBetween,
                                              Text(
                                                name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: MyColors.accentColorLight,
                                                        fontFamily: 'lexen'),
                                              ),
                                              MySpaces.hSmallGapInBetween,
                                              Text(
                                                dob,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                    color: MyColors.accentColorLight,
                                                    fontFamily: 'lexen'),
                                              ),
                                              MySpaces.hSmallGapInBetween,
                                              Text(
                                                gender,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                    color: MyColors.accentColorLight,
                                                    fontFamily: 'lexen'),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:MyDimens.double_15),
                                            child: Text(
                                              mobile,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                  color: MyColors.accentColorLight,
                                                  fontFamily: 'lexen'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:MyDimens.double_15),
                                            child: Text(
                                              address,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                  color: MyColors.accentColorLight,
                                                  fontFamily: 'lexen'),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
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
                builder: (context) => FabCircularOrganisation(),
              ),
            );
          }
        });
  }
}

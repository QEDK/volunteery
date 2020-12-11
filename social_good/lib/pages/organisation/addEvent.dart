import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_good/functions/dateTimeConverter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_good/pages/organisation/organisationEvents.dart';

String eventName = '';
String eventAddress = '';
String eventDate='';
String eventTime='';
String eventDescription='';
String orgName='';
List<String> volunteers=new List<String>();

class AddEvent extends StatefulWidget {
  static String id = "add_event";

  final User currentUser;

  AddEvent({Key key, @required this.currentUser}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState(currentUser);
}

class _AddEventState extends State<AddEvent> {
  final User currentUser;

  _AddEventState(this.currentUser);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: MyColors.white,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.primaryColor),
        borderRadius: BorderRadius.circular(MyDimens.double_25)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.primaryColor),
        borderRadius: BorderRadius.circular(MyDimens.double_25)),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.primaryColor),
        borderRadius: BorderRadius.circular(MyDimens.double_25)),
  );

  // TODO: Add Firestore support to add all these event info -- done
  void _onPressedAddEventDetails() async {
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Event').add({
      'eventName': (eventName=='')?'Beach Cleanup Drive':eventName,
      'eventAddress': (eventAddress=='')?'Girgaon Chowpatty, Mumbai': eventAddress,
      'eventDate': (eventDate=='')?'Dec 12, 2020': eventDate,
      'eventTime':(eventTime=='')?'7:00 AM': eventTime,
      'eventDescription':(eventDescription=='')?MyStrings.eventInformation:eventDescription,
      'orgName':(orgName=='')?'Leo Multiple':orgName,
      'orgUid':user.uid,
      'volunteers':volunteers,
    }).then((_) {
      print('added event details to FireStore');
    });
  }

  // Supporting Widgets for this class only.
  Widget _getText(String text, Color color) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: color, fontFamily: 'lexen'),
    );
  }

  Widget _buildEventName(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Event name', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                eventName = value;
              }),
        ],
      ),
    );
  }

  Widget _buildEventAddress(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Event address', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                eventAddress = value;
              }),
        ],
      ),
    );
  }

  Widget _buildEventDate(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Event date', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                eventDate = value;
              }),
        ],
      ),
    );
  }


  Widget _buildEventTime(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Event time', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                eventTime = value;
              }),
        ],
      ),
    );
  }

  Widget _buildEventDescription(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Event description', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                eventDescription = value;
              }),
        ],
      ),
    );
  }

  Widget _buildOrgName(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Organisation Name', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                orgName = value;
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: MyColors.accentColor, fontFamily: 'airbnb');
    TextStyle textStyle2 = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: MyColors.primaryColor, fontFamily: 'lexen');
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Material(
          child: Stack(
            children: [
              Positioned(
                top: MyDimens.double_negative_300,
                left: MyDimens.double_negative_125,
                child: Container(
                  height: MyDimens.double_600,
                  width: MyDimens.double_600,
                  decoration: BoxDecoration(
                    color: MyColors.yellowPrimary,
                    borderRadius: BorderRadius.circular(MyDimens.double_600),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MyDimens.double_15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MySpaces.vLargeGapInBetween,
                      Text(
                        MyStrings.eventSetUp,
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            color: MyColors.accentColor, fontFamily: 'airbnb'),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildEventName(textStyle1, textStyle2),
                            _buildEventDate(textStyle1, textStyle2),
                            _buildEventTime(textStyle1, textStyle2),
                            _buildEventAddress(textStyle1, textStyle2),
                            _buildEventDescription(textStyle1, textStyle2),
                            _buildOrgName(textStyle1, textStyle2),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: MyDimens.double_25),
                        child: Row(
                          children: [
                            Expanded(
                              child: RaisedButton(
                                key: Key(MyStrings.submit),
                                color: MyColors.primaryColor,
                                padding: EdgeInsets.all(MyDimens.double_15),
                                onPressed: () {
                                  _onPressedAddEventDetails();
                                  Fluttertoast.showToast(msg: 'The event has been added!');
                                  Navigator.of(context).pushNamed(OrganisationEvents.id);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(
                                        MyDimens.double_25)),
                                child: Text(
                                  MyStrings.submit,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                      color: MyColors.white,
                                      fontFamily: 'lexen'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TODO: Ensure keyboard spacing consistent -- done
                      for (int i = 0; i < 7; i++) MySpaces.vLargeGapInBetween,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_good/functions/dateTimeConverter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';
import 'package:social_good/main.dart';
import 'package:social_good/pages/organisation/addEvent.dart';
import 'package:social_good/pages/organisation/organisationEvents.dart';

String name = '';
String address = '';
String phone = '';

class OrganisationForm extends StatefulWidget {
  static String id = "organisation_form";

  final User currentUser;

  OrganisationForm({Key key, @required this.currentUser}) : super(key: key);

  @override
  _OrganisationFormState createState() => _OrganisationFormState(currentUser);
}

class _OrganisationFormState extends State<OrganisationForm> {
  final User currentUser;

  _OrganisationFormState(this.currentUser);

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

  // TODO: Add firestore support to add all these organisation info -- done
  void _onPressedAddOrganisationDetails() async {
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Organisation').doc(user.uid).set({
      'name': (name=='')?'Leo Multiple':name,
      'mobile': (phone=='')?'+91 6370548663':phone,
      'address': (address=='')?'Navi, Mumbai':address,
    }).then((_) {
      print('added organisation details to FireStore');
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

  Widget _buildAvatar() {
    bool flag = true;
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: MyDimens.double_10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(MyDimens.double_100),
                child: (currentUser.photoURL != null)
                    ? Image(
                  image: NetworkImage(currentUser.photoURL
                      .substring(0, currentUser.photoURL.length - 5) +
                      's400-c'),
                  width: MyDimens.double_200,
                  height: MyDimens.double_200,
                  fit: BoxFit.cover,
                )
                    : Image(
                  image: NetworkImage(MyStrings.larryPageUrl),
                  width: MyDimens.double_200,
                  height: MyDimens.double_200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: MyDimens.double_150,
              left: MyDimens.double_150,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MyDimens.double_30),
                    color: MyColors.primaryColor),
                child: IconButton(
                  icon: Icon(Icons.edit, color: MyColors.white),
                  onPressed: () {
                    flag = false;
                    setState(() {});
                  },
                  iconSize: MyDimens.double_25,
                ),
              ),
            ),
          ],
        ),
      ),
      width: double.infinity,
      margin: EdgeInsets.all(MyDimens.double_20),
    );
  }

  Widget _buildName(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Your organisation name', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                name = value;
              }),
        ],
      ),
    );
  }

  Widget _buildPhone(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2 * MyDimens.double_2point5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MyDimens.double_10),
            child: Text('Office number', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                phone = value;
              }),
        ],
      ),
    );
  }

  Widget _buildAddress(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Address', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onChanged: (String value) {
                address = value;
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
                        MyStrings.setUp,
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            color: MyColors.accentColor, fontFamily: 'airbnb'),
                      ),
                      _buildAvatar(),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildName(textStyle1, textStyle2),
                            _buildPhone(textStyle1, textStyle2),
                            _buildAddress(textStyle1, textStyle2),
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
                                  _onPressedAddOrganisationDetails();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => OrganisationEvents()));
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

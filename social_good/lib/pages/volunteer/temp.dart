import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_good/functions/dateTimeConverter.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/globals/mySpaces.dart';
import 'package:social_good/globals/myString.dart';

List<Color> _textColor = [
  MyColors.primaryColor,
  MyColors.primaryColor,
  MyColors.primaryColor,
];
List<Color> _bodyColor = [
  MyColors.white,
  MyColors.white,
  MyColors.white,
];
List<String> _category = [MyStrings.male, MyStrings.female, MyStrings.other];
DateTime selectedDate;

String name = '';
String gender = '';
String address = '';
String phone = '';
String dob = '${selectedDate.toLocal()}'.split(' ')[0];

class UserForm extends StatefulWidget {
  static const id = "user";
  final String currentUserId;

  UserForm({Key key, @required this.currentUserId}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
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

  // Supporting Widgets for this class only.

  // TODO: Create a cutsom stylish button to show selected option -- done
  Widget _customButton(String text, double tSize, int index, double padding) {
    return Expanded(
      child: RaisedButton(
        padding: EdgeInsets.all(padding),
        color: _bodyColor[index],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MyDimens.double_25)),
        child: _getText(text, _textColor[index]),
        onPressed: () {
          gender = _category[index];
          print(gender);
          setState(() {
            if (_bodyColor[index] == MyColors.white) {
              _bodyColor[index] = MyColors.primaryColor;
              _textColor[index] = MyColors.white;
              int i = 0, j = 1;
              if (index == 0) {
                i = 1;
                j = 2;
              } else if (index == 1) {
                i = 0;
                j = 2;
              }
              _bodyColor[i] = MyColors.white;
              _bodyColor[j] = MyColors.white;
              _textColor[i] = MyColors.primaryColor;
              _textColor[j] = MyColors.primaryColor;
            } else {
              _bodyColor[index] = MyColors.white;
              _textColor[index] = MyColors.primaryColor;
            }
          });
        },
      ),
    );
  }

  // TODO: Select date for recording DOB -- done
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate == null ? DateTime.now() : selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.primaryColor,
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dob = '${selectedDate.toLocal()}'.split(' ')[0];
      });
  }

  Widget _getDateTime(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
        print(dob);
      },
      child: Container(
        padding: EdgeInsets.all(MyDimens.double_20),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.primaryColor),
          borderRadius: BorderRadius.circular(MyDimens.double_25),
          color:
              (selectedDate == null) ? MyColors.white : MyColors.primaryColor,
        ),
        child: Row(
          children: [
            (selectedDate == null)
                ? _getText('yyyy-mm-dd', MyColors.primaryColor)
                : _getText(
                    dateTimeConverter(
                        '${selectedDate.toLocal()}'.split(' ')[0]),
                    MyColors.white),
            Spacer(),
            Icon(Icons.calendar_today,
                color: (selectedDate == null)
                    ? MyColors.primaryColor
                    : MyColors.white,
                size: 20),
          ],
        ),
      ),
    );
  }

  Widget _getText(String text, Color color) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: color, fontFamily: 'lexen'),
    );
  }

  Widget _buildName(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Your full name', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              onSaved: (String value) {
                name = value;
              }),
        ],
      ),
    );
  }

  Widget _buildPhone(TextStyle t1, TextStyle t2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Mobile number', style: t1),
          ),
          TextFormField(
              decoration: inputDecoration,
              cursorColor: MyColors.primaryColor,
              cursorRadius: Radius.circular(MyDimens.double_10),
              cursorWidth: MyDimens.double_1,
              style: t2,
              keyboardType: TextInputType.number,
              onSaved: (String value) {
                phone = value;
              }),
        ],
      ),
    );
  }

  Widget _buildGender(TextStyle t1) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Gender', style: t1),
          ),
          Row(
            children: [
              _customButton('Male', 18, 0, 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              _customButton('Female', 18, 1, 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              _customButton('Other', 18, 2, 20),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDOB(BuildContext context, TextStyle t1) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Date of Birth', style: t1),
          ),
          _getDateTime(context),
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
              onSaved: (String value) {
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
          color: MyColors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MyDimens.double_15),
            color: MyColors.white,
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
                  MySpaces.vMediumGapInBetween,
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildName(textStyle1, textStyle2),
                        _buildPhone(textStyle1, textStyle2),
                        _buildGender(textStyle1),
                        _buildDOB(context, textStyle1),
                        _buildAddress(textStyle1, textStyle2),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: MyDimens.double_25),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            key: Key(MyStrings.submit),
                            color: MyColors.primaryColor,
                            padding: EdgeInsets.all(MyDimens.double_15),
                            onPressed: () {},
                            // onPressed: () async {
                            //   if (!_formKey.currentState.validate()) {
                            //     return;
                            //   }
                            //   // If the form is valid , all the values are saved in respective variables
                            //   _formKey.currentState.save();
                            //   FirebaseUser user =
                            //   await FirebaseAuth.instance.currentUser();
                            //   email = user.email;
                            //   print(name);
                            //   print(email);
                            //   print(phone);
                            //   print(gender);
                            //   print(address);
                            //   print(dob);
                            //   print(blood);
                            //   print(height);
                            //   print(weight);
                            //   print(marital);
                            //
                            //   prefs = await SharedPreferences.getInstance();
                            //   // final doc = await Firestore.instance
                            //   //     .collection('user_details')
                            //   //     .where('email', isEqualTo: email)
                            //   //     .getDocuments();
                            //   if (true) {
                            //     await globals.uploadUserDetails(
                            //       name: name,
                            //       email: email,
                            //       gender: gender,
                            //       address: address,
                            //       dob: dob,
                            //       blood: blood,
                            //       height: height,
                            //       weight: weight,
                            //       marital: marital,
                            //       phone: phone,
                            //     );
                            //     globals.user.phone = phone;
                            //     await prefs.setString('email', email);
                            //     await prefs.setString('gender', gender);
                            //     await prefs.setString('dob', dob);
                            //     await prefs.setString('gender', gender);
                            //     await prefs.setString('dob', dob);
                            //     await prefs.setString('blood', blood);
                            //     await prefs.setString(
                            //         'height', height.toString());
                            //     await prefs.setString(
                            //         'weight', weight.toString());
                            //     await prefs.setString('marital', marital);
                            //     await prefs.setString('address', address);
                            //     await prefs.setString('phone', phone.toString());
                            //   }
                            //   // Navigator.pushNamed(context, UploadPhoto.id);
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => UploadPhoto(
                            //               currentUserId: widget.currentUserId)));
                            // },
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';

// This is a test widget for all the forms used for volunteers and organisations!
class BuildAddressTest extends StatelessWidget {
  final TextStyle t1,t2;

  const BuildAddressTest({
    Key key,
    @required this.t1,
    @required this.t2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Testing'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Address', style: t1),
              ),
              TextFormField(
                  cursorColor: MyColors.primaryColor,
                  cursorRadius: Radius.circular(MyDimens.double_10),
                  cursorWidth: MyDimens.double_1,
                  style: t2,
                  onChanged: (String value) {}),
            ],
          ),
        ),
      ),
    );
  }
}

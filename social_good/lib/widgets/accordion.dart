import 'package:flutter/material.dart';
import 'package:social_good/globals/myColors.dart';

List<String> images = [
  'beach',
  'blood',
  'beach',
  'tree',
];

List<String> headers = [
  'Beach Cleanup Drive',
  'Blood Donation Camp',
  'Educate Girl Child',
  'Plant a tree',
];

List<String> description = [
  "Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean!",
  "Donate blood and save a life today. Donate blood and save a life today. Donate blood and save a life today. Donate blood and save a life today.Donate blood and save a life today.Donate blood and save a life today.Donate blood and save a life today!",
  "Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean.Let's keep our beaches clean!",
  "Donate blood and save a life today. Donate blood and save a life today. Donate blood and save a life today. Donate blood and save a life today.Donate blood and save a life today.Donate blood and save a life today.Donate blood and save a life today!"
];

// stores ExpansionPanel state information
class Item {
  Item({
    this.id,
    this.expandedValue,
    this.headerValue,
    this.imageUrl,
  });

  int id;
  String expandedValue;
  String headerValue;
  String imageUrl;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    String img = images[index];
    String header = headers[index];
    String desc = description[index];
    return Item(
      id: index,
      headerValue: header,
      expandedValue: '$desc',
      imageUrl: 'assets/images/$img.jpg',
    );
  });
}

class MyAccordionWidget extends StatefulWidget {
  MyAccordionWidget({Key key}) : super(key: key);

  @override
  _MyAccordionWidgetState createState() => _MyAccordionWidgetState();
}

class _MyAccordionWidgetState extends State<MyAccordionWidget> {
  List<Item> _data = generateItems(4);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 180),
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      elevation: 0,
      dividerColor: MyColors.accentColorLight,
      animationDuration: Duration(milliseconds: 800),
      children: _data.map<ExpansionPanelRadio>((Item item) {
        return ExpansionPanelRadio(
          value: item.id,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListTile(
                leading: Image(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
                title: Text(item.headerValue,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: MyColors.primaryColor, fontFamily: 'airbnb')),
              ),
            );
          },
          body: ListTile(
            subtitle: Text(item.expandedValue,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: MyColors.accentColorLight, fontFamily: 'lexen')),
          ),
        );
      }).toList(),
    );
  }
}

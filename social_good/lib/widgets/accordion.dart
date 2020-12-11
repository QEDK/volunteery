import 'package:flutter/material.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/globals/myDimens.dart';
import 'package:social_good/pages/organisation/orgEventDesc.dart';
import 'package:social_good/pages/organisation/organisationEvents.dart';
import 'package:social_good/pages/volunteer/eventDesciption.dart';

class MyAccordionWidget extends StatefulWidget {
  final List<Item> data;
  final String type;

  MyAccordionWidget({Key key, @required this.data, @required this.type}) : super(key: key);

  @override
  _MyAccordionWidgetState createState() => _MyAccordionWidgetState(data, type);
}

class _MyAccordionWidgetState extends State<MyAccordionWidget> {
  final List<Item> _data;
  final String type;

  _MyAccordionWidgetState(this._data, this.type);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 180, bottom: 100),
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      elevation: 0,
      dividerColor: MyColors.orangeLighter,
      animationDuration: Duration(milliseconds: 800),
      children: _data.map<ExpansionPanelRadio>((Item item) {
        return ExpansionPanelRadio(
          value: item.id,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(MyDimens.double_200),
                  child: Image(
                    image: AssetImage(item.imageUrl),
                    width: MyDimens.double_60,
                    height: MyDimens.double_60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.headerValue,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: MyColors.accentColor, fontFamily: 'airbnb')),
              ),
            );
          },
          body: GestureDetector(
            onTap: () {
              if(type=="Organisation")
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => OrgEventDesc(eventUid: item.eventUid)));
              else
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EventDescription(eventUid: item.eventUid)));
            },
            child: ListTile(
              subtitle: Text(item.expandedValue,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: MyColors.accentColorLight, fontFamily: 'lexen')),
            ),
          ),
        );
      }).toList(),
    );
  }
}

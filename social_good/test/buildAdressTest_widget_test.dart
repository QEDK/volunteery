import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_good/globals/myColors.dart';
import 'package:social_good/widgets/buildAdressTest.dart';

int main(){
  testWidgets('My signInButtonWidget should work properly!', (WidgetTester tester) async {
    TextStyle t1=TextStyle(color: MyColors.accentColor);
    TextStyle t2=TextStyle(color: MyColors.primaryColor);
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(BuildAddressTest(t1: t1, t2: t2));

      // Create the Finders.
      final labelFinder = find.text('Address');
      final navFinder = find.text('Testing');
      final nonExistingFinder = find.text('Coding is nice');

      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(nonExistingFinder,findsNothing);
      expect(labelFinder, findsOneWidget);
      expect(navFinder, findsOneWidget);
  });
}
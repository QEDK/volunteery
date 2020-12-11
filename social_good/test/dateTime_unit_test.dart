import 'package:flutter_test/flutter_test.dart';
import 'package:social_good/functions/dateTimeConverter.dart';

int main(){
  test('Date should be properly formatted', () {
    String formattedDate = dateTimeConverter("2020-12-12");
	String expectedDate ="12 December, 2020";

    expect(formattedDate,expectedDate);
  });
}

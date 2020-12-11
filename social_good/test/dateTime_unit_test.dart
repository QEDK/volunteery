import 'package:flutter_test/flutter_test.dart';
import 'package:social_good/functions/dateTimeConverter.dart';

int main(){
  test('Date should be properly formatted', () {
    String formattedDate = dateTimeConverter(DateTime.now().toLocal().toString().split(' ')[0]);
    String expectedDate = dateTimeConverter("2020-12-11");

    expect(formattedDate,expectedDate);
  });
}
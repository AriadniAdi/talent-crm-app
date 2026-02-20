import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/extensions/json_safe_extension.dart';

void main() {
  test('getInt converts string to int', () {
    final json = {'age': '25'};
    expect(json.getInt('age'), 25);
  });

  test('getString returns empty if key not exists', () {
    final Map<String, dynamic> json = {};
    expect(json.getString('name'), '');
  });

  test('getDouble returns 0.0 if invalid', () {
    final json = {'price': 'abc'};
    expect(json.getDouble('price'), 0.0);
  });
}

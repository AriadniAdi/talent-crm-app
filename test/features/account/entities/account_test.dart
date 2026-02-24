import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/account/entities/account.dart';

void main() {
  test('Accounts with same id are equal', () {
    const a1 = Account(id: 1);
    const a2 = Account(id: 1);

    expect(a1, equals(a2));
  });

  test('Accounts with different ids are not equal', () {
    const a1 = Account(id: 1);
    const a2 = Account(id: 2);

    expect(a1, isNot(equals(a2)));
  });

  test('props contains id', () {
    const account = Account(id: 42);

    expect(account.props, [42]);
  });
}

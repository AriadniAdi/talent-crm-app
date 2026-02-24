import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';

void main() {
  late Talent talent1;
  late Talent talent2;

  setUp(() {
    talent1 = const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Dev',
      city: 'POA',
      company: 'Corp',
      website: 'site',
      contact: ContactTalent(email: 'a', phone: 'b'),
    );

    talent2 = const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Dev',
      city: 'POA',
      company: 'Corp',
      website: 'site',
      contact: ContactTalent(email: 'a', phone: 'b'),
    );
  });

  test('Equatable works correctly', () {
    expect(talent1, equals(talent2));
  });

  test('avatarUrl is deterministic for same id', () {
    expect(talent1.avatarUrl, talent2.avatarUrl);
  });

  test('avatarUrl changes with different id', () {
    const other = Talent(
      id: 2,
      name: 'John Doe',
      description: 'Dev',
      city: 'POA',
      company: 'Corp',
      website: 'site',
      contact: ContactTalent(email: 'a', phone: 'b'),
    );

    expect(talent1.avatarUrl, isNot(equals(other.avatarUrl)));
  });

  test('avatarUrl contains encoded name', () {
    expect(talent1.avatarUrl.contains('John%20Doe'), isTrue);
  });

  test('avatarUrl does not contain # in background param', () {
    expect(talent1.avatarUrl.contains('background=%23'), isFalse);
  });

  test('avatarUrl contains required query params', () {
    expect(talent1.avatarUrl.contains('color=ffffff'), isTrue);
    expect(talent1.avatarUrl.contains('size=128'), isTrue);
  });

  test('props contains all fields', () {
    expect(
      talent1.props,
      containsAll([
        1,
        'John Doe',
        'Dev',
        'POA',
        'Corp',
        'site',
        const ContactTalent(email: 'a', phone: 'b'),
      ]),
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

void main() {
  group('Talent Entity', () {
    test('two talents with same values should be equal', () {
      const t1 = Talent(
        id: 1,
        name: 'John',
        description: '',
        city: '',
        company: '',
        website: '',
        contact: ContactTalent(
          email: 'a@email.com',
          phone: '123',
        ),
      );

      const t2 = Talent(
        id: 1,
        name: 'John',
        description: '',
        city: '',
        company: '',
        website: '',
        contact: ContactTalent(
          email: 'a@email.com',
          phone: '123',
        ),
      );

      expect(t1, equals(t2));
    });

    test('should generate avatar url containing encoded name', () {
      const talent = Talent(
        id: 1,
        name: 'John Doe',
        description: '',
        city: '',
        company: '',
        website: '',
        contact: ContactTalent(
          email: 'a@email.com',
          phone: '123',
        ),
      );

      expect(talent.avatarUrl, contains('John%20Doe'));
    });

    test('avatar url should be deterministic based on id', () {
      const talent1 = Talent(
        id: 1,
        name: 'John',
        description: '',
        city: '',
        company: '',
        website: '',
        contact: ContactTalent(
          email: 'a@email.com',
          phone: '123',
        ),
      );

      const talent2 = Talent(
        id: 1,
        name: 'John',
        description: '',
        city: '',
        company: '',
        website: '',
        contact: ContactTalent(
          email: 'a@email.com',
          phone: '123',
        ),
      );

      expect(talent1.avatarUrl, equals(talent2.avatarUrl));
    });
  });
}

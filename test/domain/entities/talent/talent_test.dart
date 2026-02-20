import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';

void main() {
  const contact = ContactTalent(
    email: 'john@email.com',
    phone: '9999',
  );

  const baseTalent = Talent(
    id: 1,
    name: 'John Doe',
    description: 'Dev',
    city: 'POA',
    company: 'Tech',
    website: 'site.com',
    contact: contact,
  );

  group('Talent - value equality', () {
    test('should support value equality', () {
      const talentA = Talent(
        id: 1,
        name: 'John Doe',
        description: 'Dev',
        city: 'POA',
        company: 'Tech',
        website: 'site.com',
        contact: contact,
      );

      const talentB = Talent(
        id: 1,
        name: 'John Doe',
        description: 'Dev',
        city: 'POA',
        company: 'Tech',
        website: 'site.com',
        contact: contact,
      );

      expect(talentA, equals(talentB));
    });
  });

  group('Talent - avatarUrl', () {
    test('should generate deterministic avatarUrl for same id', () {
      final avatar1 = baseTalent.avatarUrl;
      final avatar2 = baseTalent.avatarUrl;

      expect(avatar1, avatar2);
    });

    test('should generate different avatarUrl for different ids', () {
      const talentDifferentId = Talent(
        id: 2,
        name: 'John Doe',
        description: 'Dev',
        city: 'POA',
        company: 'Tech',
        website: 'site.com',
        contact: contact,
      );

      expect(baseTalent.avatarUrl, isNot(talentDifferentId.avatarUrl));
    });

    test('should contain encoded name in avatarUrl', () {
      final url = baseTalent.avatarUrl;

      expect(url, contains('John%20Doe'));
      expect(url, contains('ui-avatars.com'));
    });
  });
}

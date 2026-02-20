import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';

void main() {
  group('Talent.hasWebsite', () {
    test('should return true when website is not empty', () {
      const talent = Talent(
        id: 1,
        name: 'John',
        description: '',
        city: '',
        company: '',
        website: 'site.com',
        contact: '',
      );

      expect(talent.hasWebsite, true);
    });

    test('should return false when website is empty', () {
      const talent = Talent(
        id: 1,
        name: 'John',
        description: '',
        city: '',
        company: '',
        website: '',
        contact: '',
      );

      expect(talent.hasWebsite, false);
    });
  });
}

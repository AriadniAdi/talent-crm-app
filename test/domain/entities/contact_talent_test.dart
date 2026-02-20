import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';

void main() {
  group('ContactTalent', () {
    test('should create contact with email and phone', () {
      const contact = ContactTalent(
        email: 'test@email.com',
        phone: '12345',
      );

      expect(contact.email, 'test@email.com');
      expect(contact.phone, '12345');
    });
  });
}

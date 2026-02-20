import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/data/models/talent_model.dart';
import 'package:talent_crm_app/domain/entities/contact_talent.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';

void main() {
  group('TalentModel.fromJson', () {
    test('should correctly parse complete json', () {
      final json = {
        'id': 1,
        'name': 'John Doe',
        'email': 'john@email.com',
        'website': 'johndoe.com',
        'phone': '9999-9999',
        'address': {'city': 'Porto Alegre'},
        'company': {'name': 'Tech Corp', 'catchPhrase': 'Innovation first'}
      };

      final model = TalentModel.fromJson(json);

      expect(model.id, 1);
      expect(model.name, 'John Doe');
      expect(model.email, 'john@email.com');
      expect(model.website, 'johndoe.com');
      expect(model.city, 'Porto Alegre');
      expect(model.catchPhrase, 'Innovation first');
      expect(model.companyName, 'Tech Corp');
      expect(model.phone, '9999-9999');
    });

    test('should return default values when json fields are null', () {
      final Map<String, dynamic> json = {};

      final model = TalentModel.fromJson(json);

      expect(model.id, 0);
      expect(model.name, '');
      expect(model.email, '');
      expect(model.website, '');
      expect(model.city, '');
      expect(model.catchPhrase, '');
      expect(model.companyName, '');
      expect(model.phone, '');
    });
  });

  group('toEntity', () {
    test('should convert model to Talent entity correctly', () {
      final model = TalentModel(
        id: 1,
        name: 'John',
        email: 'john@email.com',
        website: 'site.com',
        city: 'POA',
        catchPhrase: 'Hello world',
        companyName: 'Company',
        phone: '9999',
      );

      final entity = model.toEntity();

      expect(entity, isA<Talent>());
      expect(entity.id, 1);
      expect(entity.name, 'John');
      expect(entity.description, 'Hello world');
      expect(entity.city, 'POA');
      expect(entity.company, 'Company');
      expect(entity.website, 'site.com');

      expect(entity.contact, isA<ContactTalent>());
      expect(entity.contact.email, 'john@email.com');
      expect(entity.contact.phone, '9999');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/data/models/talent/talent_model.dart';
import 'package:talent_crm_app/domain/entities/talent/contact_talent.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';

void main() {
  group('TalentModel', () {
    late Map<String, dynamic> validJson;

    setUp(() {
      validJson = {
        'id': 1,
        'name': 'John Doe',
        'email': 'john@email.com',
        'website': 'johndoe.com',
        'phone': '9999-9999',
        'address': {'city': 'Porto Alegre'},
        'company': {
          'name': 'Tech Corp',
          'catchPhrase': 'Innovation first',
        },
      };
    });

    group('fromJson', () {
      test('should correctly parse complete json', () {
        final model = TalentModel.fromJson(validJson);

        expect(model.id, 1);
        expect(model.name, 'John Doe');
        expect(model.email, 'john@email.com');
        expect(model.website, 'johndoe.com');
        expect(model.phone, '9999-9999');
        expect(model.city, 'Porto Alegre');
        expect(model.companyName, 'Tech Corp');
        expect(model.catchPhrase, 'Innovation first');
      });

      test('should return default values when json is empty', () {
        final model = TalentModel.fromJson({});

        expect(model.id, 0);
        expect(model.name, '');
        expect(model.email, '');
        expect(model.website, '');
        expect(model.phone, '');
        expect(model.city, '');
        expect(model.companyName, '');
        expect(model.catchPhrase, '');
      });

      test('should handle null nested objects safely', () {
        final json = {
          'id': 2,
          'address': null,
          'company': null,
        };

        final model = TalentModel.fromJson(json);

        expect(model.id, 2);
        expect(model.city, '');
        expect(model.companyName, '');
        expect(model.catchPhrase, '');
      });

      test('should not crash if nested objects have unexpected type', () {
        final json = {
          'address': 'invalid',
          'company': 123,
        };

        final model = TalentModel.fromJson(json);

        expect(model.city, '');
        expect(model.companyName, '');
        expect(model.catchPhrase, '');
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
  });
}

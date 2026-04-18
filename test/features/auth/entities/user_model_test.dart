import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/auth/entities/user_model.dart';

void main() {
  final tDate = DateTime(2023, 1, 1);
  final tUserModel = UserModel(
    uid: '123',
    name: 'Test',
    email: 'test@test.com',
    phone: '123456789',
    countryCode: '+55',
    cpf: '12345678900',
    birthDate: tDate,
    createdAt: tDate,
  );

  group('UserModel', () {
    test('toFirestore should return a valid Map', () {
      final result = tUserModel.toFirestore();

      expect(result['uid'], '123');
      expect(result['name'], 'Test');
      expect(result['email'], 'test@test.com');
      expect(result['birth_date'], isA<Timestamp>());
      expect(result['data_criacao'], isA<Timestamp>());
    });

    test('fromMap should return a valid UserModel', () {
      final tData = {
        'uid': '123',
        'name': 'Test',
        'email': 'test@test.com',
        'phone': '123456789',
        'country_code': '+55',
        'cpf': '12345678900',
        'birth_date': Timestamp.fromDate(tDate),
        'data_criacao': Timestamp.fromDate(tDate),
      };

      final result = UserModel.fromMap(tData, '123');

      expect(result, tUserModel);
    });
  });
}

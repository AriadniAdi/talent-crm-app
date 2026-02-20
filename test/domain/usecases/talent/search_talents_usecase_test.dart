import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/search_talents_usecase.dart';

void main() {
  const useCase = SearchTalentsUseCase();

  final talents = [
    const Talent(
      id: 1,
      name: 'John Doe',
      description: 'Dev',
      city: 'POA',
      company: 'Tech',
      website: 'site.com',
      contact: ContactTalent(email: 'john@mail.com', phone: '9999'),
    ),
    const Talent(
      id: 2,
      name: 'Adi Machado',
      description: 'Flutter',
      city: 'POA',
      company: 'Mobile',
      website: 'adi.dev',
      contact: ContactTalent(email: 'adi@mail.com', phone: '8888'),
    ),
    const Talent(
      id: 3,
      name: 'Maria Silva',
      description: 'QA',
      city: 'SP',
      company: 'Testers',
      website: 'maria.com',
      contact: ContactTalent(email: 'maria@mail.com', phone: '7777'),
    ),
  ];

  group('SearchTalentsUseCase', () {
    test('should return original list when query is empty', () {
      final result = useCase(talents, '');
      expect(result, talents);
    });

    test('should ignore whitespace-only query and return original list', () {
      final result = useCase(talents, '   ');
      expect(result, talents);
    });

    test('should filter talents by name (case-insensitive)', () {
      final result = useCase(talents, 'john');
      expect(result.length, 1);
      expect(result.first.name, 'John Doe');

      final result2 = useCase(talents, 'ADI');
      expect(result2.length, 1);
      expect(result2.first.name, 'Adi Machado');
    });

    test('should return empty list when no match is found', () {
      final result = useCase(talents, 'xyz');
      expect(result, isEmpty);
    });

    test('should match partial name', () {
      final result = useCase(talents, 'sil');
      expect(result.length, 1);
      expect(result.first.name, 'Maria Silva');
    });
  });
}

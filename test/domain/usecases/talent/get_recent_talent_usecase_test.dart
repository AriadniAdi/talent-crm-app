import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';
import 'package:talent_crm_app/features/talent/entities/talent.dart';
import 'package:talent_crm_app/features/talent/usecases/get_recent_talent_usecase.dart';

void main() {
  const useCase = GetRecentTalentsUseCase();

  final talents = List.generate(
    6,
    (i) => Talent(
      id: i + 1,
      name: 'User ${i + 1}',
      description: 'Desc ${i + 1}',
      city: 'City',
      company: 'Company',
      website: 'site.com',
      contact: ContactTalent(
        email: 'user${i + 1}@mail.com',
        phone: '000${i + 1}',
      ),
    ),
  );

  group('GetRecentTalentsUseCase', () {
    test('should return empty list when input list is empty', () {
      final result = useCase(const []);
      expect(result, isEmpty);
    });

    test('should return first 4 items by default', () {
      final result = useCase(talents);
      expect(result.length, 4);
      expect(result.map((t) => t.id).toList(), [1, 2, 3, 4]);
    });

    test('should return limited items based on limit parameter', () {
      final result = useCase(talents, limit: 2);
      expect(result.length, 2);
      expect(result.map((t) => t.id).toList(), [1, 2]);
    });

    test('should return all items if limit is greater than list length', () {
      final result = useCase(talents, limit: 99);
      expect(result.length, talents.length);
      expect(result.map((t) => t.id).toList(), [1, 2, 3, 4, 5, 6]);
    });

    test('should return empty list if limit is zero or negative', () {
      expect(useCase(talents, limit: 0), isEmpty);
      expect(useCase(talents, limit: -1), isEmpty);
    });
  });
}

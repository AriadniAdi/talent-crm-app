import 'package:talent_crm_app/features/talent/entities/talent.dart';

class GetRecentTalentsUseCase {
  const GetRecentTalentsUseCase();

  List<Talent> call(List<Talent> all, {int limit = 4}) {
    if (all.isEmpty) return const [];
    if (limit <= 0) return const [];
    return all.take(limit).toList();
  }
}

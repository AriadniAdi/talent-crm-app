import 'package:talent_crm_app/domain/entities/talent/talent.dart';

class SearchTalentsUseCase {
  const SearchTalentsUseCase();

  List<Talent> call(List<Talent> all, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return all;

    return all.where((t) => t.name.toLowerCase().contains(q)).toList();
  }
}

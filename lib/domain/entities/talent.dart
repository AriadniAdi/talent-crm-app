import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:talent_crm_app/domain/entities/contact_talent.dart';

class Talent extends Equatable {
  final int id;
  final String name, description, city, company, website;
  final ContactTalent contact;

  const Talent({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.company,
    required this.website,
    required this.contact,
  });

  String get avatarUrl {
    final random = Random(id);
    final r = 100 + random.nextInt(156);
    final g = 100 + random.nextInt(156);
    final b = 100 + random.nextInt(156);

    final hex =
        '${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';

    return 'https://ui-avatars.com/api/?'
        'name=${Uri.encodeComponent(name)}'
        '&background=$hex'
        '&color=ffffff'
        '&bold=true';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        company,
        website,
        contact,
      ];
}

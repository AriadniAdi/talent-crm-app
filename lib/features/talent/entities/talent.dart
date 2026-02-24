import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:talent_crm_app/core/design/design.dart';
import 'package:talent_crm_app/features/talent/entities/contact_talent.dart';

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

    const base = Color(0xFF5E4AE3);
    final hsl = HSLColor.fromColor(base);

    final adjusted = hsl
        .withLightness(
          (0.55 + random.nextDouble() * 0.15).clamp(0.5, 0.7),
        )
        .toColor();

    final hex = adjusted.toHex(leadingHash: false);

    return 'https://ui-avatars.com/api/?'
        'name=${Uri.encodeComponent(name)}'
        '&background=$hex'
        '&color=ffffff'
        '&bold=false'
        '&size=128';
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

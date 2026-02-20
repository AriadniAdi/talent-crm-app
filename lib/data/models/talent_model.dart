import 'package:talent_crm_app/domain/entities/contact_talent.dart';
import 'package:talent_crm_app/domain/entities/talent.dart';

class TalentModel {
  final int id;
  final String name;
  final String email;
  final String website;
  final String city;
  final String catchPhrase;
  final String companyName;
  final String phone;

  TalentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.website,
    required this.city,
    required this.catchPhrase,
    required this.companyName,
    required this.phone,
  });

  factory TalentModel.fromJson(Map<String, dynamic> json) {
    return TalentModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      city: json['address']?['city'] ?? '',
      catchPhrase: json['company']?['catchPhrase'] ?? '',
      companyName: json['company']?['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Talent toEntity() {
    return Talent(
      id: id,
      name: name,
      description: catchPhrase,
      city: city,
      company: companyName,
      website: website,
      contact: ContactTalent(
        email: email,
        phone: phone,
      ),
    );
  }
}

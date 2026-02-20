import 'package:talent_crm_app/domain/entities/talent/contact_talent.dart';
import 'package:talent_crm_app/domain/entities/talent/talent.dart';

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
      city: _extractCity(json),
      catchPhrase: _extractCatchPhrase(json),
      companyName: _extractCompanyName(json),
      phone: json['phone'] ?? '',
    );
  }

  static String _extractCity(Map<String, dynamic> json) {
    final address = json['address'];
    if (address is Map<String, dynamic>) {
      return address['city'] ?? '';
    }
    return '';
  }

  static String _extractCatchPhrase(Map<String, dynamic> json) {
    final company = json['company'];
    if (company is Map<String, dynamic>) {
      return company['catchPhrase'] ?? '';
    }
    return '';
  }

  static String _extractCompanyName(Map<String, dynamic> json) {
    final company = json['company'];
    if (company is Map<String, dynamic>) {
      return company['name'] ?? '';
    }
    return '';
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

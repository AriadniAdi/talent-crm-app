import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final String? countryCode;
  final String? cpf;
  final DateTime? birthDate;
  final DateTime? createdAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    this.countryCode,
    this.cpf,
    this.birthDate,
    this.createdAt,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'country_code': countryCode,
      'cpf': cpf,
      'birth_date': birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      'data_criacao': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: data['uid'] ?? id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      countryCode: data['country_code'],
      cpf: data['cpf'],
      birthDate: data['birth_date'] != null ? (data['birth_date'] as Timestamp).toDate() : null,
      createdAt: data['data_criacao'] != null ? (data['data_criacao'] as Timestamp).toDate() : null,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phone,
        countryCode,
        cpf,
        birthDate,
        createdAt,
      ];
}

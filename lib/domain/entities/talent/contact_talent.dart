import 'package:equatable/equatable.dart';

class ContactTalent extends Equatable {
  final String email, phone;

  const ContactTalent({
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, phone];
}

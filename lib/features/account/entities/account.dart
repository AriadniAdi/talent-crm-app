import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final int id;

  const Account({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

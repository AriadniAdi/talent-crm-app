class RegisterParams {
  final String name, email, password, phone, countryCode, cpf, confirmPassword;
  final DateTime? birthDate;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.countryCode,
    required this.cpf,
    required this.birthDate,
    required this.confirmPassword,
  });
}

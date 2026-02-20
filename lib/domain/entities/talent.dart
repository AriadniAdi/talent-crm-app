class Talent {
  final int id;
  final String name;
  final String description;
  final String city;
  final String company;
  final String website;
  final String contact;

  const Talent({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.company,
    required this.website,
    required this.contact,
  });

  bool get hasWebsite => website.isNotEmpty;
}

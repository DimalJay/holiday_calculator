class Country {
  final String name;
  final String code;

  Country({required this.name, required this.code});

  factory Country.fromJson(Map json) => Country(
        name: json['name'],
        code: json['code'],
      );
}

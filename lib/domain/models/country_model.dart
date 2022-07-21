import 'package:holyday_calculator/country_code.dart';

class Country {
  final String name;
  final String code;

  Country({required this.name, required this.code});

  factory Country.fromJson(Map json) => Country(
        name: json['name'],
        code: json['code'],
      );

  factory Country.fromCC(String countryCode) =>
      countryCodes.singleWhere((element) => element.code == countryCode);
}

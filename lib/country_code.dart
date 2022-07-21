import 'package:holyday_calculator/domain/models/country_model.dart';

List<Country> countryCodes = [
  {"name": "United Kindom", "code": "uk"},
  {"name": "United States", "code": "usa"},
  {"name": "Sri Lanka", "code": "lk"},
  {"name": "India", "code": "indian"},
  {"name": "Russian", "code": "russian"},
  {"name": "German", "code": "german"},
  {"name": "Ukrainian", "code": "ukrainian"},
].map((e) => Country.fromJson(e)).toList()
  ..sort(
    (a, b) => (a.name).compareTo(b.name),
  );

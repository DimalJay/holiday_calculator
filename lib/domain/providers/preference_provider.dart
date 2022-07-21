import 'package:flutter/cupertino.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  // Settings Tags
  final String _darkModeTag = "DARK_MODE";
  final String _appFirstTime = "FISRT_TIME";
  final String _languageTag = "LANGUAGE";
  final String _countryTag = "COUNTRY";
  final String _isSatIsHolidayTag = "IS_SAT_IS_HOLIDAY";
  final String _isSunIsHolidayTag = "IS_SUN_IS_HOLIDAY";

  // Api Cache

  SharedPreferences sPreference;
  PreferencesProvider(this.sPreference);

  // Dark Mode
  bool get darkMode => sPreference.getBool(_darkModeTag) ?? false;
  set darkMode(bool value) => _setDarkModeToPref(value);

  void _setDarkModeToPref(bool value) async {
    await sPreference.setBool(_darkModeTag, value);
    notifyListeners();
  }

  // First Time
  bool get firstTime => sPreference.getBool(_appFirstTime) ?? true;
  set firstTime(bool value) => _setFistTimeToPref(value);

  void _setFistTimeToPref(bool value) async {
    await sPreference.setBool(_appFirstTime, value);
    notifyListeners();
  }

  // App language
  String get appLanguage => sPreference.getString(_languageTag) ?? language;
  set appLanguage(String value) => _setAppLanguageFromPref(value);

  void _setAppLanguageFromPref(String value) async {
    await sPreference.setString(_languageTag, value);
    notifyListeners();
  }

  // User Country
  String get userCountry =>
      sPreference.getString(_countryTag) ?? defaultCountry;
  set userCountry(String value) => _setUserCountryFromPref(value);

  void _setUserCountryFromPref(String value) async {
    await sPreference.setString(_countryTag, value);
    notifyListeners();
  }

  // Is Saturaday is Holiday
  bool get isSatIsHoliDay => sPreference.getBool(_isSatIsHolidayTag) ?? true;
  set isSatIsHoliDay(bool value) => _setIsSatIsHolidayToPref(value);

  void _setIsSatIsHolidayToPref(bool value) async {
    await sPreference.setBool(_isSatIsHolidayTag, value);
    notifyListeners();
  }

  // Is Sunday is Holiday
  bool get isSunIsHoliDay => sPreference.getBool(_isSunIsHolidayTag) ?? true;
  set isSunIsHoliDay(bool value) => _setIsSunIsHolidayToPref(value);

  void _setIsSunIsHolidayToPref(bool value) async {
    await sPreference.setBool(_isSunIsHolidayTag, value);
    notifyListeners();
  }

  void clear() {
    sPreference.clear();
  }
}

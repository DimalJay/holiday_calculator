import 'package:flutter/cupertino.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  // Settings Tags
  final String _darkModeTag = "DARK_MODE";
  final String _appFirstTime = "FISRT_TIME";
  final String _languageTag = "LANGUAGE";
  final String _countryTag = "COUNTRY";
  final String _isSatIsHoliday = "IS_SAT_IS_HOLIDAY";
  final String _isSunIsHoliday = "IS_SUN_IS_HOLIDAY";

  SharedPreferences sPreference;
  PreferencesProvider(this.sPreference);

  // Dark Mode
  bool get darkMode => sPreference.getBool(_darkModeTag) ?? false;
  set darkMode(bool value) => setDarkModeToPref(value);

  void setDarkModeToPref(bool value) async {
    await sPreference.setBool(_darkModeTag, value);
    notifyListeners();
  }

  // First Time
  bool get firstTime => sPreference.getBool(_appFirstTime) ?? true;
  set firstTime(bool value) => setFistTimeToPref(value);

  void setFistTimeToPref(bool value) async {
    await sPreference.setBool(_appFirstTime, value);
    notifyListeners();
  }

  // App language
  String get appLanguage => sPreference.getString(_languageTag) ?? language;
  set appLanguage(String value) => setAppLanguageFromPref(value);

  void setAppLanguageFromPref(String value) async {
    await sPreference.setString(_languageTag, value);
  }

  // User Country
  String get userCountry => sPreference.getString(_countryTag) ?? country;
  set userCountry(String value) => setUserCountryFromPref(value);

  void setUserCountryFromPref(String value) async {
    await sPreference.setString(_countryTag, value);
  }

  // Is Saturaday is Holiday
  bool get isSatIsHoliDay => sPreference.getBool(_isSatIsHoliday) ?? true;
  set isSatIsHoliDay(bool value) => setIsSatIsHolidayToPref(value);

  void setIsSatIsHolidayToPref(bool value) async {
    await sPreference.setBool(_isSatIsHoliday, value);
    notifyListeners();
  }

  // Is Sunday is Holiday
  bool get isSunIsHoliDay => sPreference.getBool(_isSunIsHoliday) ?? true;
  set isSunIsHoliDay(bool value) => setIsSunIsHolidayToPref(value);

  void setIsSunIsHolidayToPref(bool value) async {
    await sPreference.setBool(_isSunIsHoliday, value);
    notifyListeners();
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCacheProvider extends ChangeNotifier {
  static const String _apiCacheTag = "APICACHETAG";
  SharedPreferences preferences;
  ApiCacheProvider(this.preferences);

  Map<dynamic, dynamic>? readCache(String tag) {
    log("Reading From Cache $tag");
    final response = preferences.getString(_apiCacheTag + tag);
    if (response != null) {
      return jsonDecode(response);
    } else {
      return null;
    }
  }

  void writeCache(String tag, {required Map<dynamic, dynamic>? data}) async {
    log("Writing to Cache $tag");
    await preferences.setString(_apiCacheTag + tag, jsonEncode(data));
    notifyListeners();
  }

  void clear() {
    preferences.clear();
    notifyListeners();
  }
}

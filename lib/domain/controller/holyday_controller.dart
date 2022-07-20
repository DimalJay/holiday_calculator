import 'package:flutter/material.dart';
import 'package:holyday_calculator/domain/api/google_calender.dart';
import 'package:holyday_calculator/domain/handlers/holyday_handler.dart';
import 'package:holyday_calculator/domain/models/holyday.dart';

const String apiCache = "API_CACHE";

class HolidayController {
  static Future<List<Holiday>> fetch({
    required DateTime start,
    required DateTime end,
    required bool isSat,
    required bool isSun,
    required String language,
  }) async {
    final Map syncData = await GoogleCalenderApi(
      countryCode: language.toLowerCase(),
      languageCode: "en",
    ).fetchApi();

    HolydayHandler handler = HolydayHandler(syncData);
    return handler.filterHolyDays(
      start: start,
      end: end,
      isSat: isSat,
      isSun: isSun,
    );
  }

  static int getDaysFromRange(DateTimeRange range) {
    return range.end.difference(range.start).inDays;
  }
}

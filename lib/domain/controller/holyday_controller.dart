import 'package:flutter/material.dart';
import 'package:holyday_calculator/domain/api/google_calender.dart';
import 'package:holyday_calculator/domain/controller/cache_controller.dart';
import 'package:holyday_calculator/domain/handlers/holyday_handler.dart';
import 'package:holyday_calculator/domain/models/holyday.dart';
import 'package:provider/provider.dart';

const String apiCache = "API_CACHE";

class HolidayController {
  static Future<List<Holiday>> fetch(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    required bool isSat,
    required bool isSun,
    required String country,
  }) async {
    final apiCache = Provider.of<ApiCacheProvider>(context);
    final Map syncData;

    if (apiCache.readCache(country) != null) {
      syncData = apiCache.readCache(country)!;
    } else {
      syncData = await GoogleCalenderApi(
        countryCode: country.toLowerCase(),
        languageCode: "en",
      ).fetchApi();
      apiCache.writeCache(country, data: syncData);
    }

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

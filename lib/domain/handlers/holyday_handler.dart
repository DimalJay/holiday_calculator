import 'package:holyday_calculator/domain/models/holyday.dart';

class HolydayHandler {
  final Map response;

  HolydayHandler(this.response);

  List<Holiday> _convertToHolidayModels() {
    List items = response['items'];
    return items.map((e) => Holiday.fromJson(e)).toList();
  }

  List<Holiday> filterHolyDays({
    required DateTime start,
    required DateTime end,
    required bool isSat,
    required bool isSun,
  }) {
    final daysToGenerate = end.difference(start).inDays;
    final days = List.generate(daysToGenerate,
        (i) => DateTime(start.year, start.month, start.day + (i)));

    final holidays = _convertToHolidayModels().where(
      (element) {
        return element.date.compareTo(start) > 0 &&
            element.date.compareTo(end) < 0;
      },
    ).toList();

    final weekends = days
        .where((element) {
          bool satCheck = element.weekday == DateTime.saturday;
          bool sunCheck = element.weekday == DateTime.sunday;

          return (isSat && satCheck) || (isSun && sunCheck);
        })
        .map((e) =>
            Holiday(date: e, summary: "Weekend", tag: parseDateType(null, e)))
        .toList();
    weekends.removeWhere(
      (element) => holidays.where((e) => e.date == element.date).isNotEmpty,
    );

    return (weekends + holidays)..sort((a, b) => a.date.compareTo(b.date));
  }
}

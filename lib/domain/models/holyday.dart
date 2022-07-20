import 'package:flutter/material.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:holyday_calculator/domain/models/date_tag.dart';

class Holiday {
  final DateTime date;
  final String summary;
  final DateTag tag;

  const Holiday({
    required this.date,
    required this.summary,
    required this.tag,
  });

  factory Holiday.fromJson(Map doc) {
    String summary = doc['summary'];
    DateTime date = DateTime.parse(doc['start']['date']);

    return Holiday(
      date: date,
      summary: summary,
      tag: parseDateType(summary, date),
    );
  }
}

DateTag parseDateType(String? summary, DateTime date) {
  if (summary?.contains("Poya") ?? false) {
    return DateTag(
      icon: moonIcon,
      color: Colors.orange,
      title: "Poya Day",
    );
  } else if (summary?.contains("Public") ?? false) {
    return DateTag(
      icon: erathIcon,
      color: Colors.purple,
      title: "Public Holiday",
    );
  } else if (summary == null &&
      [DateTime.saturday, DateTime.sunday].contains(date.weekday)) {
    return DateTag(
      icon: weekIcon,
      color: Colors.green,
      title: "Weekend",
    );
  } else {
    return DateTag(
      icon: erathIcon,
      color: Colors.purple,
      title: "Public Holiday",
    );
  }
}

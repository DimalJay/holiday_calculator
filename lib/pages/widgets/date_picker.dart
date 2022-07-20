import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

typedef DatePickerCallBack = void Function(PickerDateRange pickerDateRange);

class DatePickerWidget extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final DateRangePickerController controller;
  final DatePickerCallBack callBack;
  const DatePickerWidget({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.callBack,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      headerHeight: 80,
      view: DateRangePickerView.month,
      initialSelectedRange: PickerDateRange(startDate, endDate),
      selectionMode: DateRangePickerSelectionMode.range,
      onSelectionChanged: (args) {
        if (args.value is PickerDateRange) {
          callBack.call(args.value);
        }
      },
      allowViewNavigation: true,
      monthViewSettings:
          const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
      controller: controller,
      monthCellStyle: DateRangePickerMonthCellStyle(
        weekendDatesDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

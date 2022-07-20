import 'package:syncfusion_flutter_datepicker/datepicker.dart';

final suggestions = {
  "Next Week": PickerDateRange(
    DateTime.now(),
    DateTime.now().add(const Duration(days: 7)),
  ),
  "Next 30 Days": PickerDateRange(
    DateTime.now(),
    DateTime.now().add(const Duration(days: 30)),
  ),
  "Next 2 Months": PickerDateRange(
    DateTime.now(),
    DateTime.now().add(const Duration(days: 60)),
  ),
};

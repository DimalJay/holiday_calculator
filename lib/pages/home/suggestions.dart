import 'package:flutter/material.dart';
import 'package:holyday_calculator/constraints/app_data.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

typedef SuggestionSelectCallBack = bool Function(PickerDateRange);

class HomeSuggestions extends StatelessWidget {
  final Function(PickerDateRange) onPressed;
  final SuggestionSelectCallBack selected;
  const HomeSuggestions(
      {Key? key, required this.onPressed, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children:
            suggestions.entries.map((e) => _buildChip(e, context)).toList(),
      ),
    );
  }

  Widget _buildChip(MapEntry<String, PickerDateRange> e, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding * .5),
      child: RawChip(
        label: Text(e.key),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius / 1.5),
            side: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.primary,
            )),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        selected: selected.call(e.value),
        selectedColor: primaryColor.withOpacity(0.2),
        onPressed: () => onPressed.call(e.value),
      ),
    );
  }
}

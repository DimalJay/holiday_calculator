import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:holyday_calculator/domain/controller/holyday_controller.dart';
import 'package:holyday_calculator/domain/models/date_tag.dart';
import 'package:holyday_calculator/domain/models/holyday.dart';
import 'package:holyday_calculator/pages/result/radial_progress.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatelessWidget {
  final DateTimeRange dateTimeRange;
  final bool onSat;
  final bool onSun;
  final String language;
  const ResultPage({
    Key? key,
    required this.dateTimeRange,
    this.onSat = true,
    this.onSun = true,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Holiday>>(
          future: HolidayController.fetch(
            start: dateTimeRange.start,
            end: dateTimeRange.end,
            isSat: onSat,
            isSun: onSun,
            language: language,
          ),
          builder: (context, snapshot) {
            List<Holiday> holidays = snapshot.data ?? [];
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  title: Text("Available Holidays"),
                ),
                SliverToBoxAdapter(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      width: constraints.maxWidth,
                      height: constraints.maxWidth,
                      padding: const EdgeInsets.all(kPadding * 4),
                      child: RadialProgressWidget(
                        max: HolidayController.getDaysFromRange(dateTimeRange)
                            .round(),
                        value: holidays.length,
                      ),
                    );
                  }),
                ),
                if (snapshot.hasData)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _holidayCard(context,
                              holiday: holidays[index]);
                        },
                        childCount: holidays.length,
                      ),
                    ),
                  )
              ],
            );
          }),
    );
  }

  Padding _holidayCard(BuildContext context, {required Holiday holiday}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding,
        vertical: kPadding / 3,
      ),
      child: Container(
        padding: const EdgeInsets.all(kPadding * 1.5),
        decoration: BoxDecoration(
          color: holiday.tag.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              holiday.summary,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: holiday.tag.color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: kPadding / 3),
            Text(
              DateFormat.yMMMMEEEEd().format(holiday.date),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.5),
                  ),
            ),
            const SizedBox(height: kPadding),
            _dateChip(tag: holiday.tag),
          ],
        ),
      ),
    );
  }

  Widget _dateChip({
    required DateTag tag,
    Size size = const Size(30, 30),
  }) {
    return Row(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: tag.color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(size.width / 4),
          child: SvgPicture.asset(
            tag.icon,
            color: tag.color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
          child: Text(
            tag.title,
            style: TextStyle(color: tag.color),
          ),
        )
      ],
    );
  }
}

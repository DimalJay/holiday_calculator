import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holyday_calculator/constraints/app_data.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:holyday_calculator/country_code.dart';
import 'package:holyday_calculator/pages/admob.dart';
import 'package:holyday_calculator/pages/home/suggestions.dart';
import 'package:holyday_calculator/pages/result.dart';
import 'package:holyday_calculator/pages/widgets/date_picker.dart';
import 'package:holyday_calculator/pages/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late DateTimeRange dateTimeRange;
  late DateRangePickerController dateRangePickerController;
  bool isSat = true;
  bool isSun = true;
  String country = "lk";

  late AdmobIntergration admobIntergration;

  // Animation Controller
  late AnimationController _animationController;
  late Animation _animation;

  // Global Key
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    admobIntergration = AdmobIntergration();
    admobIntergration.createInterstitialAd();
    admobIntergration.createRewardedInterstitialAd();

    // Animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 20.0, end: 24.0).animate(_animationController);

    dateRangePickerController = DateRangePickerController();
    dateTimeRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(days: 30)),
    );

    super.initState();
  }

  @override
  void dispose() {
    admobIntergration.interstitialAd?.dispose();
    admobIntergration.rewardedInterstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: _appBar(context),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Suggested Holiday Ranges",
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: kPadding * .8),

              // Suggestions List
              HomeSuggestions(onPressed: (range) {
                setState(() {
                  dateRangePickerController.selectedRange = range;
                  dateTimeRange = DateTimeRange(
                    start: range.startDate ?? dateTimeRange.start,
                    end: range.endDate ?? dateTimeRange.end,
                  );
                });
              }, selected: (range) {
                return range.startDate!.compareTo(dateTimeRange.start) == 0;
              }),
              SizedBox(
                height: 50,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: suggestions.entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding * .5),
                            child: RawChip(
                                label: Text(e.key),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        kBorderRadius / 1.5),
                                    side: BorderSide(
                                      width: 1.5,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                selected: e.value.startDate!
                                        .compareTo(dateTimeRange.start) ==
                                    0,
                                selectedColor: primaryColor.withOpacity(0.2),
                                onPressed: () {
                                  setState(() {
                                    dateRangePickerController.selectedRange =
                                        e.value;
                                    dateTimeRange = DateTimeRange(
                                      start: e.value.startDate ??
                                          dateTimeRange.start,
                                      end: e.value.endDate ?? dateTimeRange.end,
                                    );
                                  });
                                }),
                          ))
                      .toList(),
                ),
              ),
              DropdownButton<String>(
                value: country,
                hint: const Text("Choose Country"),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                elevation: 16,
                isExpanded: true,
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    country = newValue!;
                  });
                },
                items: countryCodes.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value['code'],
                    child: Text(value['name']!),
                  );
                }).toList(),
              ),
              LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth * 1.3,
                  child: DatePickerWidget(
                    startDate: dateTimeRange.start,
                    endDate: dateTimeRange.end,
                    controller: dateRangePickerController,
                    callBack: (dateRange) {
                      setState(() {
                        dateTimeRange = DateTimeRange(
                          start: dateRange.startDate ?? dateTimeRange.start,
                          end: dateRange.endDate ?? dateTimeRange.end,
                        );
                      });
                    },
                  ),
                );
              }),
              Row(
                children: [
                  _weekendCheckBox(
                      title: "Saturday is Holiday",
                      value: isSat,
                      onChanged: (value) {
                        setState(() {
                          isSat = value ?? false;
                        });
                      }),
                  _weekendCheckBox(
                      title: "Sunday is Holiday",
                      value: isSun,
                      onChanged: (value) {
                        setState(() {
                          isSun = value ?? false;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return ResultPage(
                dateTimeRange: dateTimeRange,
                onSat: isSat,
                onSun: isSun,
                language: country,
              );
            }));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            textStyle: Theme.of(context).textTheme.headline6,
            elevation: 1.0,
            splashFactory: InkSplash.splashFactory,
            primary: Theme.of(context).buttonTheme.colorScheme?.primary,
            onPrimary: Colors.white,
          ),
          label: const Text(
            "Calculate",
          ),
          icon: const Icon(Icons.calculate),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: _appBarTitle(context),
      bottom: _appBarBottom(context),
      leading: _appBarLeading(),
      actions: [_rewardButton()],
    );
  }

  IconButton _rewardButton() {
    return IconButton(
      onPressed: () {
        admobIntergration.showRewardedInterstitialAd();
      },
      icon: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Image.asset(
          giftIcon,
          height: _animation.value,
        ),
      ),
    );
  }

  IconButton _appBarLeading() {
    return IconButton(
        icon: SvgPicture.asset(
          menuIcon,
          width: 24.0,
          height: 24.0,
        ),
        onPressed: () {
          _globalKey.currentState?.openDrawer();
        });
  }

  PreferredSize _appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        height: 100,
        padding: const EdgeInsets.all(kPadding),
        child: Row(
          children: [
            _dateDisplaySnippet(title: "Start Date", date: dateTimeRange.start),
            const SizedBox(width: kPadding),
            _dateDisplaySnippet(title: "End Date", date: dateTimeRange.end),
          ],
        ),
      ),
    );
  }

  RichText _appBarTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Holiday ".toUpperCase(),
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: kSmallFontSize * .8,
            ),
        children: [
          TextSpan(
            text: "Calculator".toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _weekendCheckBox({
    required bool value,
    required String title,
    required Function(bool?) onChanged,
  }) {
    return Expanded(
      child: Row(
        children: [
          Checkbox(
            onChanged: onChanged,
            value: value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius * .2),
            ),
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget _dateDisplaySnippet({required String title, required DateTime date}) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: kPadding * .2),
            Text(
              DateFormat.yMEd().format(date),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

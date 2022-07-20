import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:holyday_calculator/country_code.dart';
import 'package:holyday_calculator/pages/admob.dart';
import 'package:holyday_calculator/pages/home/suggestions.dart';
import 'package:holyday_calculator/pages/result/result.dart';
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

  // Admob
  late AdmobIntergration admobIntergration;

  // Animation Controller
  late AnimationController _animationController;
  late Animation _animation;

  // Global Key
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // Admob Initialization
    admobIntergration = AdmobIntergration();
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
              // Build Title
              _buildTitle(context),

              const SizedBox(height: kPadding * .8),

              // Suggestions List
              _buildSuggestions(),

              // Language Selector
              _buildLangSelector(),

              // Calaneder View
              _calanderView(),

              // Weekend Select
              _weekendSelector(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBarButton(context),
    );
  }

  Widget _buildBottomBarButton(BuildContext context) {
    return Padding(
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
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text("Suggested Holiday Ranges",
        style: Theme.of(context).textTheme.headline6);
  }

  HomeSuggestions _buildSuggestions() {
    return HomeSuggestions(onPressed: (range) {
      setState(() {
        dateRangePickerController.selectedRange = range;
        dateTimeRange = DateTimeRange(
          start: range.startDate ?? dateTimeRange.start,
          end: range.endDate ?? dateTimeRange.end,
        );
      });
    }, selected: (range) {
      return range.startDate!.compareTo(dateTimeRange.start) == 0;
    });
  }

  Row _weekendSelector() {
    return Row(
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
    );
  }

  LayoutBuilder _calanderView() {
    return LayoutBuilder(builder: (context, constraints) {
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
    });
  }

  DropdownButton<String> _buildLangSelector() {
    return DropdownButton<String>(
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

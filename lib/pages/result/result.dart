import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:holyday_calculator/domain/controller/holyday_controller.dart';
import 'package:holyday_calculator/domain/models/country_model.dart';
import 'package:holyday_calculator/domain/models/date_tag.dart';
import 'package:holyday_calculator/domain/models/holyday.dart';
import 'package:holyday_calculator/domain/providers/preference_provider.dart';
import 'package:holyday_calculator/pages/result/radial_progress.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatefulWidget {
  final DateTimeRange dateTimeRange;
  final bool onSat;
  final bool onSun;
  final String country;
  const ResultPage({
    Key? key,
    required this.dateTimeRange,
    this.onSat = true,
    this.onSun = true,
    required this.country,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      log('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          log('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Holiday>>(
          future: HolidayController.fetch(
            context,
            start: widget.dateTimeRange.start,
            end: widget.dateTimeRange.end,
            isSat: widget.onSat,
            isSun: widget.onSun,
            country: widget.country,
          ),
          builder: (context, snapshot) {
            List<Holiday> holidays = snapshot.data ?? [];

            if (snapshot.connectionState == ConnectionState.done) {
              return _body(context,
                  holidays: holidays, hasData: snapshot.hasData);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Scaffold(
                appBar: _appbar(context),
                body: const Center(child: Text("Hmm, Having Trouble")),
              );
            }
          }),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: Text(
          "Available Holidays in ${Country.fromCC(context.read<PreferencesProvider>().userCountry).name}"),
    );
  }

  CustomScrollView _body(BuildContext context,
      {required List<Holiday> holidays, required bool hasData}) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text(
              "Available Holidays in ${Country.fromCC(context.read<PreferencesProvider>().userCountry).name}"),
        ),
        SliverToBoxAdapter(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              padding: const EdgeInsets.all(kPadding * 4),
              child: RadialProgressWidget(
                max: HolidayController.getDaysFromRange(widget.dateTimeRange)
                    .round(),
                value: holidays.length,
              ),
            );
          }),
        ),
        if (hasData)
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _holidayCard(context, holiday: holidays[index]);
                },
                childCount: holidays.length,
              ),
            ),
          ),
        if (holidays.isEmpty)
          const SliverToBoxAdapter(
            child: Center(child: Text(":( You have no Any Holidays")),
          ),
        if (_anchoredAdaptiveAd != null && _isLoaded)
          SliverToBoxAdapter(
            child: Container(
              color: Colors.green,
              width: _anchoredAdaptiveAd!.size.width.toDouble(),
              height: _anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            ),
          )
      ],
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

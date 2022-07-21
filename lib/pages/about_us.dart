import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:holyday_calculator/constraints/values.dart';
import 'package:holyday_calculator/domain/providers/preference_provider.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: const AssetImage(companyLogo),
                    fit: BoxFit.cover,
                    invertColors: context.read<PreferencesProvider>().darkMode,
                  ),
                ),
              ),
              const SizedBox(height: kPadding * .8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPadding * .3),
                child: Text(
                  companyName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                companySologan,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height: kPadding),
              Container(
                padding: const EdgeInsets.all(kPadding * .9),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(kBorderRadius * .6),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).cardColor,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outlined,
                          size: kSmallFontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(
                          width: kSmallFontSize * .5,
                        ),
                        Text(
                          "Who Are We?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: kPadding * .6),
                    Text(
                      whoareweDescription,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

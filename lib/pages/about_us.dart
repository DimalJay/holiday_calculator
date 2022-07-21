import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:holyday_calculator/constraints/values.dart';

String htmlData = """<div>
  <h1>Demo Page</h1>
  <p>This is a fantastic product that you should buy!</p>
  <h3>Features</h3>
  <ul>
    <li>It actually works</li>
    <li>It exists</li>
    <li>It doesn't cost much!</li>
  </ul>
  <!--You can pretty much put any html in here!-->
</div>""";

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: HtmlWidget(
          htmlData,
          textStyle: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
